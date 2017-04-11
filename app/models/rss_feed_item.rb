class RssFeedItem < ApplicationRecord
  belongs_to :rss_feed, inverse_of: :rss_feed_items
  has_and_belongs_to_many :chatrooms, inverse_of: :rss_feed_items

  scope :current,   ->              {where('created_at > ?', 2.days.ago)}
  scope :used,      ->(chatroom_id) {where(id: Chatroom.find_by(id: chatroom_id).rss_feed_items.pluck(:id))}
  scope :unused,    ->(chatroom_id) {where.not(id: Chatroom.find_by(id: chatroom_id).rss_feed_items.pluck(:id))}

  def sanitized_description
    self.description.partition('<').first
  end
end
