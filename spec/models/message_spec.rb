require 'rails_helper'

RSpec.describe Message, type: :model do
  subject{build :message, :is_topic}

  describe 'sanity check' do
    it{expect(subject).to be_valid}

    let(:no_chatroom){build(:message, :is_topic, :no_chatroom)}
    it 'must belong to a chatroom' do
      expect(no_chatroom).not_to be_valid
      expect(no_chatroom.save).to be_falsey
    end

    let(:no_message_type){build(:message)}
    it 'must have a message_type' do
      expect(no_message_type).not_to be_valid
      expect(no_message_type.save).to be_falsey
    end

    let(:no_body){build(:message, :is_topic, :no_body)}
    it 'must have a body' do
      expect(no_body).not_to be_valid
      expect(no_body.save).to be_falsey
    end

    let(:no_user_user_post){build(:message, :is_user_post, :no_user)}
    it 'must have a user if it is a user post' do
      expect(no_user_user_post).not_to be_valid
      expect(no_user_user_post.save).to be_falsey
    end
  end

  describe '#is_user_post?' do
    let(:topic){build(:message, :is_topic)}
    let(:user_post){build(:message, :is_user_post)}
    context 'is a user post' do
      it 'should return true' do
        expect(user_post.is_user_post?).to be_truthy
      end
    end

    context 'is a topic' do
      it 'should return false' do
        expect(topic.is_user_post?).to be_falsey
      end
    end
  end

  describe '#is_topic?' do
    let(:topic){build(:message, :is_topic)}
    let(:user_post){build(:message, :is_user_post)}
    context 'is a user post' do
      it 'should return false' do
        expect(user_post.is_topic?).to be_falsey
      end
    end

    context 'is a topic' do
      it 'should return true' do
        expect(topic.is_topic?).to be_truthy
      end
    end
  end
end
