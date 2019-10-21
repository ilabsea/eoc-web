class CreateFirebaseToken < ActiveRecord::Migration[5.2]
  def change
    create_table :firebase_tokens do |t|
      t.string :token
    end
  end
end
