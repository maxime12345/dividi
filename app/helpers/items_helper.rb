module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_tag item.photo, alt: "#{item.name}", class: "image-item"
    else
      image_tag("fallback/default-picture.png", class: "fallback")
    end
  end

  def url_image(item)
    if item.photo.present?
      item.photo
    else
      File.open("#{Rails.root}/app/assets/images/fallback/default-picture.png")
    end
  end

  # retourne un hash avec toutes les informations en fonction de l'utilisateur connecté
  def hash_status(item)
    status = {text: "", icon: "", button: nil, renter: nil}
    # Si item fantome
    if item.id.nil?
      status[:text] = "Je l\'emprunte"
      status[:icon] = "fas fa-user-circle"

    # Si pas de reminder
    elsif item.reminders.size.zero?
      status[:text] = "Disponible"
      status[:icon] = "far fa-check-circle"
        if item.collection.user == current_user
          if item.verbe == "To Rent" || item.verbe == "To Lend"
            status[:button] = "declare"
          end
        else
          status[:button] = "notifier"
        end
    else

      # si reminder avec le statut nil (réservation validée)
      if !item.validate_reminder.nil?
        # Si l'item appartient à l'utilisateur
        if item.collection.user == current_user
          status[:icon] = "far fa-times-circle"
          status[:button] = "available again"
            # Si l'item est prêt à qqun hors réseau (pas de user dans la bdd)
            if item.reminders.where(status: nil)[0].user.nil?
              status[:renter] = User.new(username: item.reminders.where(status: nil)[0].ghost_name, email: "(Hors réseau)")
            else
              status[:renter] = item.reminders.where(status: nil)[0].user
            end
          if item.verbe == "To Rent"
            status[:text] = "En cours de location"
          else
            status[:text] = "En cours de prêt"
          end
        # si le reminder validé appartient au current_user
        elsif item.validate_reminder.user == current_user
          status[:icon] = "fas fa-user-circle"
          if item.verbe == "To Rent"
            status[:text] = "Je le loue"
          else
            status[:text] = "Je l\'emprunte"
          end
        else # l'objet est loué par quelqu'un d'autre
          status[:icon] = "far fa-times-circle"
          if item.pending_reminders.where(user: current_user).size.zero?
            status[:button] = "notifier"
            status[:text] = "Indisponible"
          else
            status[:button] = "cancel"
            status[:text] = "Indisponible, demande envoyée"
          end
        end

      else # status "pending"
        if item.collection.user == current_user
          status[:text] = "Demandes en cours"
          status[:icon] = "far fa-question-circle"
          if item.borrowable?
            status[:button] = "declare"
          end
        elsif !item.reminders.where(user: current_user).size.zero?
          status[:text] = "Attente de retour"
          status[:icon] = "far fa-question-circle"
          status[:button] = "cancel"
        else
          status[:text] = "Disponible"
          status[:icon] = "far fa-check-circle"
          status[:button] = "notifier"
        end
      end
    end
  return status
  end

  def my_reminder(item)
    item.reminders.where(user: current_user)[0]
  end

  def button(verbe)
    if verbe == "declare"
      link_to "Déclarer", new_item_reminder_path(params[:id]), class: "btn btn-primary"
    elsif verbe == "notifier"
      link_to "Envoyer une notification", item_reminders_path(@item,
      reminder: {user_id: current_user, status: "pending"}),
      method: :post, class: "btn btn-primary"
    elsif verbe == "available again"
      link_to "Objet rendu", reminder_path(@item.validate_reminder), class: "btn btn-primary",
      method: :delete,
      data: {confirm: "Etes-vous à nouveau en possession de cet objet ?" }
    elsif verbe == "cancel"
      link_to "Annuler ma notification", reminder_path(my_reminder(@item)), class: "btn btn-primary",
      method: :delete,
      data: {confirm: "Etes-vous sûr d'annuler cette notification ?" }
    end

  end
end
