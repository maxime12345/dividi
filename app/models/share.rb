# frozen_string_literal: true

class Share < ApplicationRecord
  belongs_to :collection
  belongs_to :network
end
