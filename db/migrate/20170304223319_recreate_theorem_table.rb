class RecreateTheoremTable < ActiveRecord::Migration
  def change
    drop_table :theorems
    create_table :theorems do |t|
      t.integer :claim_id
      t.integer :argument_id
      
      t.timestamps null: false
    end
  end
end
