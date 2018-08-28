class Item < ApplicationRecord
  belongs_to :collection
  has_many :reminders
  monetize :price_cents
  mount_uploader :photo, PhotoUploader
end
