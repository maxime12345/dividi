# frozen_string_literal: true

class AddGhostItemToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :ghost_item, :string
  end
end
