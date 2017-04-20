FactoryGirl.define do
  factory :category do
    name Faker::Lorem.sentence(2)

    trait :no_name do
      name nil
    end

    trait :has_rss_feeds do
      after :build do |category|
        rss_feeds {build_list(:rss_feed)}
      end
    end

    trait :has_chatrooms do
      after :build do |chatroom|
        chatrooms {build_list(:chatroom)}
      end
    end
  end
end
