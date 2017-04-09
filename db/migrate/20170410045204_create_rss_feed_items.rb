class CreateRssFeedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :rss_feed_items do |t|
      t.references :rss_feed, foreign_key: true
      t.string :title
      t.string :link
      t.string :description

      t.timestamps
    end
  end
end
