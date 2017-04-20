require 'rss'

class RssFeed < ApplicationRecord
  has_many :rss_articles, inverse_of: :rss_feed
  has_and_belongs_to_many :categories, inverse_of: :rss_feeds

  validates :title,       presence: true
  validates :link,        presence: true
  validates :description, presence: true

  before_validation :process_rss_feed, on: :create
  after_create :scrape_articles

  def scrape_articles
    RssDataScraperJob.perform_later(id)
  end

  private
  
  def process_rss_feed
    rss_reader = RssReader.new(link)
    assign_attributes(rss_reader.channel_data)
  end
end
