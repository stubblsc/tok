class CategoryMembership < ApplicationRecord
  belongs_to :category
  belongs_to :rss_feed
end
