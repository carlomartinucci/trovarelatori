class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.string :name
      t.belongs_to :theme, index: true

      t.timestamps null: false
    end
    add_foreign_key :arguments, :themes

    add_column :theorems, :argument_id, :integer, index: true
    add_foreign_key :theorems, :arguments
  end
end
