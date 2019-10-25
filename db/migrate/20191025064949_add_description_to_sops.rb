class AddDescriptionToSops < ActiveRecord::Migration[5.2]
  def change
    add_column :sops, :description, :text
  end
end
