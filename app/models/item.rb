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
