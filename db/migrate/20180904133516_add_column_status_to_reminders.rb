class AddColumnStatusToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :status, :string
  end
end
