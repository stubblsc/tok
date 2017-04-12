class CreateJoinTableCategoriesRssFeeds < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :rss_feeds do |t|
      # t.index [:category_id, :rss_feed_id]
      # t.index [:rss_feed_id, :category_id]
    end
  end
end
