class CreateTheorems < ActiveRecord::Migration
  def change
    create_table :theorems do |t|
      t.string :connection
      t.belongs_to :claim, index: true

      t.timestamps null: false
    end
    add_foreign_key :theorems, :claims
  end
end
