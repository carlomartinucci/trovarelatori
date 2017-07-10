class AddUserToTheoremsAndArguments < ActiveRecord::Migration
  def change
    add_column :theorems, :user_id, :integer
    add_column :arguments, :user_id, :integer
  end
end
