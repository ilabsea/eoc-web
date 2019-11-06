class AddTagsToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :tags, :text, array: true, default: []
  end
end
