class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email, :string
    add_column :users, :birthday, :string
    add_column :users, :gender, :string
  end
end
