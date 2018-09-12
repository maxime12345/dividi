module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_tag item.photo, alt: "#{item.name}", class: "image-item"
    else
      image_tag("fallback/default-picture.png")
    end
  end

  def url_image(item)
    if item.photo.present?
      item.photo
    else
      File.open("#{Rails.root}/app/assets/images/fallback/default-picture.png")
    end
  end

  # return the display
  def status(item)
    # if no reminder
    if item.id.nil?
      '<i class="fas fa-user-circle"></i> Je l\'emprunte'.html_safe
    elsif item.reminders.size.zero?
      '<i class="far fa-check-circle"></i> Disponible'.html_safe
    else
        # if reminder(s)

      if !item.reminders.where(status: nil).size.zero? # status : nil
        if item.collection.user == current_user
          if item.verbe == "To Rent"
            '<i class="far fa-times-circle"></i> En cours de location'.html_safe
          else
            '<i class="far fa-times-circle"></i> En cours de prêt'.html_safe
          end
        elsif item.reminders[0].user == current_user
          if item.verbe == "To Rent"
            '<i class="fas fa-user-circle"></i> Je le loue'.html_safe
          else
            '<i class="fas fa-user-circle"></i> Je l\'emprunte'.html_safe
          end
        else
          '<i class="far fa-times-circle"></i> Indisponible'.html_safe
        end

      else # status "pending"
        if item.collection.user == current_user
          '<i class="far fa-question-circle"></i> Demandes en cours'.html_safe
        elsif !item.reminders.where(user: current_user).size.zero?
          '<i class="far fa-question-circle"></i> Attente de retour'.html_safe
        else
          '<i class="far fa-check-circle"></i> Disponible'.html_safe

        end
      end
    end
  end
end
