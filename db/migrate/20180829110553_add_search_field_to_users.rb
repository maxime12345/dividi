class AddSearchFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_for_search, :string
  end
end
