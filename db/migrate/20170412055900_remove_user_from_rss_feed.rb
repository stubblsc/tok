class RemoveUserFromRssFeed < ActiveRecord::Migration[5.0]
  def change
    remove_reference :rss_feeds, :user, foreign_key: true
  end
end
