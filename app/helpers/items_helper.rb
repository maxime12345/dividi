# frozen_string_literal: true

module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_tag item.photo, alt: item.name.to_s, class: 'image-item'
    else
      image_tag('fallback/default-picture.png', class: 'fallback')
    end
  end

  def url_image(item)
    if item.photo.present?
      item.photo
    else
      File.open("#{Rails.root}/app/assets/images/fallback/default-picture.png")
    end
  end

  # returns a hash with all the information according to the logged user

  def hash_status(item)
    status = { text: '', icon: '', button: nil, renter: nil }
    # Si item fantome
    if item.id.nil?
      status[:text] = "Je l\'emprunte"
      status[:icon] = 'fas fa-user-circle'

    # Si pas de reminder
    elsif item.reminders.size.zero?
      status[:text] = 'Disponible'
      status[:icon] = 'far fa-check-circle'
      if item.collection.user == current_user
        status[:button] = 'declare' if item.verbe == 'To Rent' || item.verbe == 'To Lend'
      else
        status[:button] = 'notifier'
      end
    elsif !item.validate_reminder.nil? # if reminder with status nil (reservation validated)
      # If the item belongs to the user
      if item.collection.user == current_user
        status[:icon] = 'far fa-times-circle'
        status[:button] = 'available again'
        # If the item is loaned to someone outside the network (no user in the database)
        status[:renter] = if item.reminders.where(status: nil)[0].user.nil?
                            User.new(username: item.reminders.where(status: nil)[0].ghost_name, email: '(Hors réseau)')
                          else
                            item.reminders.where(status: nil)[0].user
                          end
        status[:text] = if item.verbe == 'To Rent'
                          'En cours de location'
                        else
                          'En cours de prêt'
                        end
      # if the validated reminder belongs to the current_user
      elsif item.validate_reminder.user == current_user
        status[:icon] = 'fas fa-user-circle'
        status[:text] = if item.verbe == 'To Rent'
                          'Je le loue'
                        else
                          "Je l\'emprunte"
                        end
      else # the object is rented by someone else
        status[:icon] = 'far fa-times-circle'
        if item.pending_reminders.where(user: current_user).size.zero?
          status[:button] = 'notifier'
          status[:text] = 'Indisponible'
        else
          status[:button] = 'cancel'
          status[:text] = 'Indisponible, demande envoyée'
        end
      end

    elsif item.collection.user == current_user # status "pending"
      status[:text] = 'Demandes en cours'
      status[:icon] = 'far fa-question-circle'
      status[:button] = if item.borrowable?
                          'declare'
                        else
                          'delete'
                        end
    elsif !item.reminders.where(user: current_user).size.zero?
      status[:text] = 'Attente de retour'
      status[:icon] = 'far fa-question-circle'
      status[:button] = 'cancel'
    else
      status[:text] = 'Disponible'
      status[:icon] = 'far fa-check-circle'
      status[:button] = 'notifier'
    end
    status
  end

  def my_reminder(item)
    item.reminders.where(user: current_user)[0]
  end

  def button(verbe)
    if verbe == 'declare'
      link_to 'Déclarer', new_item_reminder_path(params[:id]), class: 'btn btn-primary'
    elsif verbe == 'notifier'
      link_to 'Envoyer une notification', item_reminders_path(@item,
                                                              reminder: { user_id: current_user, status: 'pending' }),
              method: :post, class: 'btn btn-primary'
    elsif verbe == 'available again'
      link_to 'Objet rendu', reminder_path(@item.validate_reminder), class: 'btn btn-primary',
                                                                     method: :delete,
                                                                     data: { confirm: 'Etes-vous à nouveau en possession de cet objet ?' }
    elsif verbe == 'cancel'
      link_to 'Annuler ma notification', reminder_path(my_reminder(@item)), class: 'btn btn-primary',
                                                                            method: :delete,
                                                                            data: { confirm: "Etes-vous sûr d'annuler cette notification ?" }
    elsif verbe == 'delete'
      link_to 'Objet vendu ou donné', item_path(@item), class: 'btn btn-primary',
                                                        method: :delete,
                                                        data: { confirm: 'Voulez-vous supprimer cet objet car il est vendu ou donné ?' }
    end
  end
end
