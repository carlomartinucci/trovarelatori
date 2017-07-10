class AddAnagraphicsToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :first_name
    add_column :users, :second_name, :string
    add_column :users, :gender, :string
    add_column :users, :city, :string
    add_column :users, :birthday, :datetime
  end
end
