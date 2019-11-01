class FirebaseDeviceToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
end