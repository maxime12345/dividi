class Network < ApplicationRecord
  belongs_to :user
  has_many :network_users, dependent: :destroy
  has_many :shares, dependent: :destroy

  has_many :validate_network_users, ->{where(status: nil)}, class_name: 'NetworkUser'
  has_many :pending_network_users, ->{where(status: "pending")}, class_name: 'NetworkUser'
end
