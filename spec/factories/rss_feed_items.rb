FactoryGirl.define do
  factory :rss_feed_item do
    rss_feed
    title Faker::Lorem.sentence(4)
    link Faker::Internet.url
    description Faker::Lorem.sentence(8)
  end
end
