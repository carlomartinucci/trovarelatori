class AddUserToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :user_id, :integer
  end
end
