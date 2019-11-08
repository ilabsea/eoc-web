# frozen_string_literal: true

class AddIsDeletedToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :is_deleted, :boolean, default: false
    add_index :categories, :is_deleted
  end
end
