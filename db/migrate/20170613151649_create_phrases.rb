class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.integer :claim_id
      t.integer :theorem_id
      t.integer :position, default: 0

      t.timestamps null: false
    end
    add_index :phrases, :claim_id
    add_index :phrases, :theorem_id
    add_index :phrases, [:claim_id, :theorem_id]
  end
end
