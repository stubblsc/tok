FactoryGirl.define do
  factory :message do
    chatroom
    user
    body Faker::Lorem.paragraph(3)
  end
end
