class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.references :user, foreign_key: true
      t.references :objet, foreign_key: true

      t.timestamps
    end
  end
end
