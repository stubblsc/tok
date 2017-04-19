require 'rss'

class RssFeed < ApplicationRecord
  has_many :rss_articles, inverse_of: :rss_feed
  has_and_belongs_to_many :categories, inverse_of: :rss_feeds

  validates :title,       presence: true
  validates :link,        presence: true
  validates :description, presence: true

  around_create :process_rss_feed

  def self.scrape_articles_all_feeds
    RssFeed.find_each do |feed|
      feed.scrape_articles
    end
  end

  def scrape_articles
    RssDataScraperJob.perform_now(id)
  end

  private

  def process_rss_feed
    rss_reader = RssReader.new(link)
    assign_attributes(rss_reader.channel_data)

    yield

    scrape_articles
  end
end
