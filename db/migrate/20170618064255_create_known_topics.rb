class CreateKnownTopics < ActiveRecord::Migration
  def change
    create_table :known_topics do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :knowledge

      t.timestamps null: false
    end
    add_index :known_topics, :user_id
    add_index :known_topics, :topic_id
    add_index :known_topics, [:user_id, :topic_id]
  end
end
