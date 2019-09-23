class AddDocumentTypeToSop < ActiveRecord::Migration[5.2]
  def change
    add_column :sops, :document_type, :integer, default: 0
  end
end
