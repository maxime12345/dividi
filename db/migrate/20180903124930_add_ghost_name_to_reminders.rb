# frozen_string_literal: true

class AddGhostNameToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :ghost_name, :string
  end
end
