FactoryGirl.define do
  factory :message do
    chatroom
    body Faker::Lorem.paragraph(3)

    trait :no_chatroom do
      chatroom nil
    end

    trait :no_body do
      body nil
    end

    trait :no_user do
      user nil
    end

    trait :is_user_post do
      user
      message_type :user_post
    end

    trait :is_topic do
      message_type :topic
    end
  end
end
