# frozen_string_literal: true

class AddPhotoToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :photo, :string
  end
end
