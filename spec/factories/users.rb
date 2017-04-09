FactoryGirl.define do
  factory :user do
    transient do
      user_password Faker::Internet.password
    end

    email Faker::Internet.email
    username Faker::Internet.user_name
    password user_password
    password_confirmation user_password
  end
end
