FactoryGirl.define do
  factory :chatroom_user do
    chatroom
    user
    last_read_at Faker::Time.between(DateTime.now - 1, DateTime.now)
  end
end
