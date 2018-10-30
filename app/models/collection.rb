# frozen_string_literal: true

class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :shares, dependent: :destroy

  # By default, collections will always be sorted by name
  default_scope -> { order(:name) }
end
