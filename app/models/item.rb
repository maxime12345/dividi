class Item < ApplicationRecord
  belongs_to :collection
  monetize :price_cents
end
