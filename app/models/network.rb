class Network < ApplicationRecord
  belongs_to :user
  has_many :network_users
end
