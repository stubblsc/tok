FactoryGirl.define do
  factory :rss_feed do
    title Faker::Lorem.sentence(4)
    link 'http://rss.cnn.com/rss/cnn_topstories.rss'
    description Faker::Lorem.sentence(8)

    trait :has_language do
      language Faker::Lorem.word
    end

    trait :has_pub_date do
      pub_date Faker::Time.between(DateTime.now - 1, DateTime.now)
    end

    trait :last_build_date do
      last_build_date Faker::Time.between(DateTime.now - 1, DateTime.now)
    end
  end
end
