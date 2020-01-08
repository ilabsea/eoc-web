# frozen_string_literal: true

class CreateSops < ActiveRecord::Migration[5.1]
  def change
    create_table :sops do |t|
      t.string   :name
      t.string   :file
      t.integer  :category_id
      t.integer  :author_id


      t.timestamps
    end
  end
end
