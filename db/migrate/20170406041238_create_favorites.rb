class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :favoritable_id
      t.string :favoritable_type

      t.timestamps null: false
    end
    add_index :favorites, :user_id
    add_index :favorites, [:favoritable_type, :favoritable_id]
  end
end
