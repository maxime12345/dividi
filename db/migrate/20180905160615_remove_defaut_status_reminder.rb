class RemoveDefautStatusReminder < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reminders, :status, nil
  end
end
