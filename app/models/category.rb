class Category < ApplicationRecord
  has_many :chatroom, inverse_of: :categories
  has_and_belongs_to_many :rss_feeds, inverse_of: :categories
end
