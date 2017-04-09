class RssFeedItem < ApplicationRecord
  belongs_to :rss_feed, inverse_of: :rss_feed_items
end
