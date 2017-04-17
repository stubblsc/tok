FactoryGirl.define do
  factory :category do
    name Faker::Lorem.sentence(2)
    chatroom
    rss_feed
  end
end
