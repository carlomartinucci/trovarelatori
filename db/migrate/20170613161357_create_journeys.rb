class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :journeys, :user_id
  end
end
