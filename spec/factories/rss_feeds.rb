FactoryGirl.define do
  factory :rss_feed do
    title Faker::Lorem.sentence(4)
    link 'http://rss.cnn.com/rss/cnn_topstories.rss'
    description Faker::Lorem.sentence(8)

    trait :no_title do
      title nil
    end

    trait :no_link do
      link nil
    end

    trait :no_description do
      description nil
    end

    trait :has_language do
      language Faker::Lorem.word
    end

    trait :has_pub_date do
      pub_date Faker::Time.between(DateTime.now - 1, DateTime.now)
    end

    trait :last_build_date do
      last_build_date Faker::Time.between(DateTime.now - 1, DateTime.now)
    end

    trait :has_10_rss_articles do
      after :build do |rss_feed|
        rss_feed.rss_articles << build(:rss_article, rss_feed_id: rss_feed.id)
        rss_feed.save
      end
    end
  end
end
