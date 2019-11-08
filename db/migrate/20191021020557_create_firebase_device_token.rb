# frozen_string_literal: true

class CreateFirebaseDeviceToken < ActiveRecord::Migration[5.2]
  def change
    create_table :firebase_device_tokens do |t|
      t.string :token
    end
  end
end
