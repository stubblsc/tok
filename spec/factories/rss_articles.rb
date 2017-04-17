FactoryGirl.define do
  factory :rss_article do
    rss_feed
    title Faker::Lorem.sentence(4)
    link Faker::Internet.url
    description "#{Faker::Lorem.sentence(8)}<#{Faker::Lorem.sentence(8)}"

    trait :no_title do
      title nil
    end

    trait :no_link do
      link nil
    end

    trait :no_description do
      description nil
    end

    trait :no_rss_feed do
      rss_feed nil
    end
  end
end
