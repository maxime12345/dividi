class CreateShares < ActiveRecord::Migration[5.2]
  def change
    create_table :shares do |t|
      t.references :collection, foreign_key: true
      t.references :network, foreign_key: true

      t.timestamps
    end
  end
end
