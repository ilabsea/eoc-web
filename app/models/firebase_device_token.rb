# == Schema Information
#
# Table name: firebase_device_tokens
#
#  id    :bigint           not null, primary key
#  token :string
#

class FirebaseDeviceToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
end
