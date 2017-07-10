class AddIndexValueToClaims < ActiveRecord::Migration
  def change
    add_index :claims, :value
  end
end
