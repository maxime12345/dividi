class Collection < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :shares, dependent: :destroy

  # Par défaut, les collections seront toujours triées selon le name
  default_scope -> { order(:name) }


end
