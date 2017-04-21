FactoryGirl.define do
  factory :chatroom do
    category
    name Faker::Lorem.sentence(3)

    trait :no_name do
      name nil
    end

    trait :no_category do
      category nil
    end

    trait :is_full do
      after :create do |chatroom|
        10.times do
          chatroom.users << create(:user)
        end
        chatroom.save
      end
    end
  end
end
