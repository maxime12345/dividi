class Item < ApplicationRecord
  searchkick

  belongs_to :collection
  belongs_to :category
  has_one :user, through: :collection
  has_many :reminders

  validates :name, presence: true
  validates :verbe, presence: true

  monetize :price_cents
  mount_uploader :photo, PhotoUploader

  def available?
    reminders[0].nil? || reminders[0].status == "pending"
  end

  # def search_data
  #   attributes.merge(category: self.categories.map(&:name))
  # end

  # include PgSearch
  # pg_search_scope :search_by_name,
  #   against: [ :name],
  #   using: {
  #     tsearch: { prefix: true }
  #   }

end
