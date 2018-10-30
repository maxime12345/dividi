# frozen_string_literal: true

class CreateNetworks < ActiveRecord::Migration[5.2]
  def change
    create_table :networks do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
