class Item < ApplicationRecord
  belongs_to :collection
  has_one :user, through: :collection

  monetize :price_cents
  mount_uploader :photo, PhotoUploader
end
