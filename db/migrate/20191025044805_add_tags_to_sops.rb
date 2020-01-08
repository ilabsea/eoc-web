# frozen_string_literal: true

class AddTagsToSops < ActiveRecord::Migration[5.2]
  def change
    add_column :sops, :tags, :text, array: true, default: []
  end
end
