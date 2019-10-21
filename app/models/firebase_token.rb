class FirebaseToken < ApplicationRecord
  validates :token, presence: true, uniqueness: true
end