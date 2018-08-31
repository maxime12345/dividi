module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_path(item.photo, height: 300, width: 400, crop: :fill)
    else
    ""
    end
  end
end


# https://via.placeholder.com/300x300
