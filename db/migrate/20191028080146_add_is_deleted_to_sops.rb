class AddIsDeletedToSops < ActiveRecord::Migration[5.2]
  def change
    add_column :sops, :is_deleted, :boolean, default: false
    add_index :sops, :is_deleted
  end
end
