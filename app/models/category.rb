class Category < ApplicationRecord
  belongs_to :chatroom, inverse_of: :categories
  belongs_to :rss_feed, inverse_of: :categories
end
