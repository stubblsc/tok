class AddIsRssFeedUserToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_rss_feed_user, :boolean
  end
end
