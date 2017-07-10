class AddAnagraphicPrivacyToUser < ActiveRecord::Migration
  def change
    add_column :users, :public_email, :boolean, default: true
    add_column :users, :public_phone, :boolean, default: false
    add_column :users, :public_city, :boolean, default: true
    add_column :users, :public_birthday, :boolean, default: false
  end
end
