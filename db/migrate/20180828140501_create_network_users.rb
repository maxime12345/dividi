class CreateNetworkUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :network_users do |t|
      t.string :status
      t.references :network, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
