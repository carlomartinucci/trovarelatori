class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :theme_id
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_index :topics, :theme_id
  end
end
