FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{Faker::Internet.user_name}_#{n}@email.com"}
    username Faker::Internet.user_name
    password Faker::Internet.password
  end
end
