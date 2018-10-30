# frozen_string_literal: true

FactoryGirl.define do
  sequence(:name) { |n| "Test Object #{n}" }

  factory :item do
    name
    association :category
    price 0

    trait :to_rent_or_lend do
      verbe { 'To Lend' }
    end

    trait :to_sell_or_give do
      verbe { 'To Give' }
    end

    factory :item_to_rent_or_lend, traits: [:to_rent_or_lend]
    factory :item_to_sell_or_give, traits: [:to_sell_or_give]
  end
end
