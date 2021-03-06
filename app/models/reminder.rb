# frozen_string_literal: true

class Reminder < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item, optional: true
end
