class Category < ApplicationRecord
   has_many :items
   validates :name, presence: true, uniqueness: true

   default_scope -> { order(:name) }
end
