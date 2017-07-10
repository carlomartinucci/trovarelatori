class RemoveUselessTables < ActiveRecord::Migration
  def change
    drop_table :arguments
    drop_table :causes
    drop_table :claims
    drop_table :connections
    drop_table :favorites
    drop_table :journeys
    drop_table :phrases
    drop_table :stages
    drop_table :theorems
  end
end
