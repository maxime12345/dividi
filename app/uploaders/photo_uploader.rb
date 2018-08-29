# app/uploaders/photo_uploader.rb
class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  # include CarrierWave::MiniMagick

  def public_id
    if model.is_a?(Item)
      "dividi/#{model.class}/#{model.name}"
    else
      "dividi/#{model.class}/#{model.id}"
    end
  end

  process :resize_to_limit => [500, nil]

end
