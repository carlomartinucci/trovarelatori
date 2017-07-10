class RenameDescriptionToKeywordsInTopic < ActiveRecord::Migration
  def change
    rename_column :topics, :description, :keywords
  end
end
