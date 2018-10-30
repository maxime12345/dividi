# frozen_string_literal: true

class NetworkUser < ApplicationRecord
  belongs_to :network
  belongs_to :user

  has_one :owner, through: :network, source: :user
  # has_one :reverse_network_user, ->{where(user: class_name: 'User')}, through: :owner, source: :network_users
end
