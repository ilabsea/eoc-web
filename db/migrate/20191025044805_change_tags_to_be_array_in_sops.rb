# frozen_string_literal: true

class ChangeTagsToBeArrayInSops < ActiveRecord::Migration[5.2]
  def up
    change_column :sops, :tags, :text, array: true, default: [], using: "(string_to_array(tags, ','))"
  end

  def down
    change_column :sops, :tags, :text, array: false, default: nil, using: "(array_to_string(tags, ','))"
  end
end
