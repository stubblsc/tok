FactoryGirl.define do
  factory :chatroom do
    name Faker::Lorem.sentence(3)
  end
end
