require 'rss'

class RssFeed < ApplicationRecord
  has_many :rss_feed_items, inverse_of: :rss_feed
  belongs_to :user, inverse_of: :rss_feed
  has_and_belongs_to_many :categories, inverse_of: :rss_feeds

  after_initialize :setup_feed

  def self.enqueue_feed_for_processing
    RssFeed.each do |feed|
      RssDataScraperJob.perform_async(feed.id)
    end
  end

  def pull_rss_feed_items
    feed = RSS::Parser.parse(open(self.link)).channel

    feed.items.each do |feed_item|
      RssFeedItem.find_or_create_by(rss_feed_id: self.id, title: feed_item.title,
                                    description: feed_item.description,
                                    link: feed_item.link)
    end
  end

  private

  def setup_feed
    pull_feed_info
    create_rss_feed_user
  end

  def pull_feed_info
    feed = RSS::Parser.parse(open(self.link)).channel

    self.title = feed.title
    self.description = feed.description
    self.language = feed.language
    self.pub_date = feed.pubDate
    self.last_build_date = last_build_date
  end

  def create_rss_feed_user
    self.user = User.create(email: "#{self.username}@tok.com", username: self.username,
                            password: self.username, password_confirmation: self.username,
                            is_rss_feed_user: true)
    self.save
  end
end
