class AddUniqConstraintNameToSop < ActiveRecord::Migration[5.2]
  def change
    add_index :sops, :name, unique: true
  end
end
