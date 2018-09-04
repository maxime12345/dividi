class ChangeDefaultStatusReminders < ActiveRecord::Migration[5.2]
  def change
    change_column :reminders, :status, :string, default: 'pending'
  end
end
