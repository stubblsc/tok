class Chatroom < ApplicationRecord
  has_many :chatroom_users, inverse_of: :chatroom, dependent: :destroy
  has_many :users, through: :chatroom_users, inverse_of: :chatrooms
  has_many :messages, inverse_of: :chatroom, dependent: :destroy
  has_and_belongs_to_many :rss_feed_items, inverse_of: :chatrooms
  has_many :categories, inverse_of: :chatrooms
  has_many :rss_feeds, through: :categories, inverse_of: :chatrooms

  scope :public_channels, -> {where(direct_message: false)}
  scope :direct_messages, -> {where(direct_message: true)}

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

  def potential_feed_items
    RssFeedItem.current.where(rss_feed_id: self.rss_feeds.map.pluck(:id)).unused(self.id)
  end

  def post_new_topic(chatroom_id)
    rss_feed_item = self.potential_feed_items.sample

    Message.create(chatroom_id: self.id, user_id: self.user_id, type: 'topic',
                    topic_url: rss_feed_item.link,
                    text: rss_feed_item.sanitized_description)
  end
end
