FactoryGirl.define do
  factory :item_to_rent_or_lend, class: Item do
    sequence(:name) { |n| "Test Object #{n}" }
    verbe "To Lend"
    association :category
    price 0
  end
  factory :item_to_sell_or_give, class: Item do
    sequence(:name) { |n| "Test Object #{n}" }
    verbe "To Give"
    association :category
  end
end
