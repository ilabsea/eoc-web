# frozen_string_literal: true

class RemoveNameUniqueIndexFromSops < ActiveRecord::Migration[5.2]
  def change
    remove_index :sops, :name
  end
end
