class CreateJoinTableChatroomsRssFeedItems < ActiveRecord::Migration[5.0]
  def change
    create_join_table :chatrooms, :rss_feed_items do |t|
      # t.index [:chatroom_id, :rss_feed_item_id]
      # t.index [:rss_feed_item_id, :chatroom_id]
    end
  end
end
