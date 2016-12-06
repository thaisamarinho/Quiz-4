FactoryGirl.define do
  factory :auction do
    association :user
    title         { Faker::Lorem.word }
    description   { Faker::Lorem.paragraph }
    ends_on       { Faker::Date.forward(30) }
    reserve_price { rand(1000) + 1 }
  end
end
