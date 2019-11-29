# frozen_string_literal: true

# == Schema Information
#
# Table name: sops
#
#  id            :bigint           not null, primary key
#  name          :string
#  file          :string
#  tags          :text
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  document_type :integer          default("document")
#

FactoryBot.define do
  factory :sop do
    name { FFaker::Name.name }
    tags { FFaker::Tweet.tags }

    # Note: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |sop, _evaluator|
        sop.reindex(refresh: true)
      end
    end
  end
end
