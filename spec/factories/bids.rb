FactoryGirl.define do
  factory :bid do
    association :user
    association :auction
    price { rand(1000) + 1 }
  end
end
