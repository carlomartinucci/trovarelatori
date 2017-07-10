class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :journey_id
      t.integer :stageable_id
      t.integer :stageable_type

      t.timestamps null: false
    end
    add_index :stages, :journey_id
    add_index :stages, [:stageable_id, :stageable_type]
  end
end
