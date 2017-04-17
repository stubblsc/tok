require 'rss'

class RssDataScraperJob < ApplicationJob
  queue_as :rss_data

  def perform(rss_feed_id)
    feed = RssFeed.find_by(id: rss_feed_id)

    feed.pull_rss_articles
  end
end
