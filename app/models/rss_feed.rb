class RssFeed < ApplicationRecord
  has_many :rss_feed_items, inverse_of: :rss_feed
  belongs_to :user, inverse_of: :rss_feed

  after_create :create_rss_feed_user

  def sanitized_description
    self.description.partition('<').first
  end

  def pull_rss_feed_items
    feed = RSS::Parser.parse(open(self.url)).channel

    feed.items.each do |feed_item|
      RssFeedItem.find_or_create_by(rss_feed_id: self.id, title: feed_item.title,
                                    description: feed_item.description,
                                    link: feed_item.link)
    end
  end

  def post_message
  end

private
  def create_rss_feed_user
    self.user = User.create(email: "#{self.username}@tok.com", username: self.username,
                            password: self.username, password_confirmation: self.username,
                            is_rss_feed_user: true)
    self.save
  end
end
