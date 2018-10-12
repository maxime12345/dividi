class Item < ApplicationRecord
  searchkick

  Searchkick.search_timeout = 3

  belongs_to :collection
  belongs_to :category
  has_one :user, through: :collection
  has_many :reminders

  has_many :pending_reminders, -> {where(status: "pending")}, class_name: 'Reminder'
  has_one :validate_reminder, -> {where(status: nil)}, class_name: 'Reminder'

  validates :name, presence: true
  validates :verbe, presence: true

  monetize :price_cents, disable_validation: true

  mount_uploader :photo, PhotoUploader

  def available?
    validate_reminder.nil?
  end

  def waiting_list?
    pending_reminders.size != 0
  end

  def borrowable?
    verbe == "To Lend" || verbe == "To Rent"
  end

  def text(point_of_view)
    if point_of_view == "out"
      case verbe
      when "To Give" then "Don"
      when "To Sell" then "Vente: #{price_cents.fdiv(100).to_i}€"
      when "To Lend" then "Prêt"
      when "To Rent" then "Location: #{price_cents.fdiv(100).to_i}€/jour"
      else
        verbe
      end
    else
      case verbe
      when "To Lend" then "Emprunté à:"
      when "To Rent" then "Loué #{price_cents.fdiv(100).to_i}€/jour à:"
      else
        verbe
      end
    end
  end

  def self.to_give
    where(verbe: 'To Give')
  end

  def self.to_lend
    where(verbe: 'To Lend')
  end
end
