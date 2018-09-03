module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_tag item.photo, alt: "#{item.name}", class: "cloudinary-show"
    else
      image_tag("fallback/default-picture.png")
    end
  end
end
