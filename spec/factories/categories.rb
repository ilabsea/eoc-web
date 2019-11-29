# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { FFaker::Name.name }

    # Note: This should be the last trait in the list so `reindex` is called
    # after all the other callbacks complete.
    trait :reindex do
      after(:create) do |category, _evaluator|
        category.reindex(refresh: true)
      end
    end
  end
end
