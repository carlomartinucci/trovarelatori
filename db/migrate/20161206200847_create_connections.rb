class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :reason_id
      t.integer :consequence_id

      t.timestamps null: false
    end
    add_index :connections, :reason_id
    add_index :connections, :consequence_id
    add_index :connections, [:reason_id, :consequence_id], unique: true
  end
end
