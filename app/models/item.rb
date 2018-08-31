class Item < ApplicationRecord
  searchkick

  belongs_to :collection
  belongs_to :category
  has_one :user, through: :collection
  has_many :reminders

  validates :name, presence: true

  monetize :price_cents
  mount_uploader :photo, PhotoUploader

  # include PgSearch
  # pg_search_scope :search_by_name,
  #   against: [ :name],
  #   using: {
  #     tsearch: { prefix: true }
  #   }

end
