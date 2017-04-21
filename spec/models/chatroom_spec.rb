require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  subject{build :chatroom}

  describe 'sanity check' do
    it{expect(subject).to be_valid}

    let(:no_name){build(:chatroom, :no_name)}
    it 'must have a name' do
      expect(no_name).not_to be_valid
      expect(no_name.save).to be_falsey
    end

    let(:no_category){build(:chatroom, :no_category)}
    it 'must have a category' do
      expect(no_category).not_to be_valid
      expect(no_category.save).to be_falsey
    end
  end

  describe '#topics' do
    it 'should return the correct number of messages' do
      subject.save
      user = create :user
      create_list(:message, 10, message_type: :topic, chatroom_id: subject.id)
      create_list(:message, 10, message_type: :user_post, user_id: user.id, chatroom_id: subject.id)
      expect(subject.topics.count).to eq 10
    end

    it 'should have the correct messages' do
      subject.save
      user = create :user
      topics = create_list(:message, 10, message_type: :topic, chatroom_id: subject.id)
      create_list(:message, 10, message_type: :user_post, user_id: user.id, chatroom_id: subject.id)
      expect(subject.topics).to eq topics
    end
  end

  describe '#user_posts' do
    it 'should return the correct number of messages' do
      subject.save
      user = create :user
      create_list(:message, 10, message_type: :topic, chatroom_id: subject.id)
      create_list(:message, 10, message_type: :user_post, user_id: user.id, chatroom_id: subject.id)
      expect(subject.user_posts.count).to eq 10
    end

    it 'should have the correct messages' do
      subject.save
      user = create :user
      create_list(:message, 10, message_type: :topic, chatroom_id: subject.id)
      user_posts = create_list(:message, 10, message_type: :user_post, user_id: user.id, chatroom_id: subject.id)
      expect(subject.user_posts).to eq user_posts
    end
  end

  describe '#add_user_to_chatroom' do
    context 'chatroom is not full' do
      it 'should not create a new chatroom and should add user to the existing chatroom' do
        subject.save
        user = create :user
        original_chatroom_count = Chatroom.count
        original_user_count = subject.users.count
        subject.add_user_to_chatroom(user)

        expect(Chatroom.count).to eq original_chatroom_count
        expect(subject.users.count).to eq original_user_count + 1
        expect(Chatroom.last.users.include? user).to be_truthy
      end
    end

    context 'chatroom is full' do
      it 'should create a copy of the chatroom with the new user' do
        full_chatroom = create(:chatroom, :is_full)
        user = create :user
        original_chatroom_count = Chatroom.count
        full_chatroom.add_user_to_chatroom(user)

        expect(Chatroom.count).to eq original_chatroom_count + 1
        expect(Chatroom.last.attributes.delete_if{|k,_| k == "id"}).to eq(full_chatroom.attributes.delete_if{|k,_| k == "id"})
        expect(Chatroom.last.users.count).to eq 1
        expect(Chatroom.last.users.first).to eq user
      end
    end
  end

  describe '#potential_feed_items' do
  end
end
