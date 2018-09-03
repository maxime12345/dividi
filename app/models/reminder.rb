class Reminder < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item
  validates :item_id, uniqueness: { scope: :user_id }
end
