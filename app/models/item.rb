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

  def text
    if available?
      if verbe == "To Give"
        "Don"
      elsif verbe == "To Sell"
        "Vente: #{price_cents.fdiv(100).to_i}€"
      elsif verbe == "To Lend"
        "Prêt"
      elsif verbe == "To Rent"
        "Location: #{price_cents.fdiv(100).to_i}€/jour"
      else
        verbe
      end
    else
      if verbe == "To Lend"
        "Emprunté à:"
      elsif verbe == "To Rent"
        "Loué #{price_cents.fdiv(100).to_i}€/jour à:"
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
