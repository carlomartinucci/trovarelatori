class RemoveFuzzily < ActiveRecord::Migration
  def change
    remove_index(:trigrams, :name => 'index_for_match')
    remove_index(:trigrams, :name => 'index_by_owner')
    drop_table :trigrams
  end
end
