class Chatroom < ApplicationRecord
  has_many :chatroom_users, inverse_of: :chatroom, dependent: :destroy
  has_many :users, through: :chatroom_users, inverse_of: :chatrooms
  has_many :messages, inverse_of: :chatroom, dependent: :destroy
  has_many :rss_feeds, through: :categories, inverse_of: :chatrooms
  has_and_belongs_to_many :rss_articles, inverse_of: :chatrooms
  belongs_to :category, inverse_of: :chatrooms

  scope :public_channels, -> {where(direct_message: false)}
  scope :direct_messages, -> {where(direct_message: true)}

  MAX_USERS = 10

  def self.direct_message_for_users(users)
    user_ids = users.map(&:id).sort
    name = "DM:#{user_ids.join(":")}"

    if chatroom = direct_messages.where(name: name).first
      chatroom
    else
      # create a new chatroom
      chatroom = new(name: name, direct_message: true)
      chatroom.users = users
      chatroom.save
      chatroom
    end
  end

  def topics
    self.messages.topics
  end

  def user_posts
    self.messages.user_posts
  end

  def potential_feed_items
    RssArticle.current.unused(self.id)
  end

  def get_new_topic
    potential_feed_items.sample
  end

  def post_new_topic
    new_topic = self.get_new_topic

    Message.create(chatroom_id: self.id, user_id: User.last.id,
                    type: :topic, topic_url: new_topic.link,
                    body: new_topic.sanitized_description)
  end

  def add_user_to_chatroom(user_id)
    user = User.find_by(id: user_id)

    unless self.users >= MAX_USERS
      self.users << user
      self.save
    else
      new_chatroom = duplicate_chatroom
      new_chatroom.users << user
      new_chatroom.save
    end
  end

  private

  def duplicate_chatroom
    new_chatroom = self.dup

    new_chatroom.messages.delete_all
    new_chatroom.users.delete_all

    new_chatroom.save
    new_chatroom
  end
end
