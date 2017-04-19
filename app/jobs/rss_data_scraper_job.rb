require 'rss'

class RssDataScraperJob < ApplicationJob
  queue_as :rss_data

  def perform(rss_feed_id)
    feed = RssFeed.find_by(id: rss_feed_id)
    rss_reader = RssReader.new(feed.link)
    articles = []

    rss_reader.article_data.each do |article_params|
      article_params[:feed_id] = rss_feed_id

      article = RssArticle.find_or_initialize_by(article_params)

      articles << article if article.new_record?
    end

    feed.articles = articles
    feed.save
  end
end
