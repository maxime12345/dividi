class Item < ApplicationRecord
  belongs_to :collection
  monetize :price_cents
  mount_uploader :photo, PhotoUploader
end
