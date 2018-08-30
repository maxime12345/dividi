# app/uploaders/photo_uploader.rb
class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  # include CarrierWave::MiniMagick

  def public_id
    folder = Rails.env.production? ? "dividi_production" : "dividi_development_#{ENV['USER']}"

    if model.is_a?(Item)
      "dividi/#{folder}/#{model.class}/#{model.user.id}-#{model.name}"
    else
      "dividi/#{folder}/#{model.class}/#{model.email}"
    end
  end

    process :resize_to_limit => [600, 600]


end
