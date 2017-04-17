class CreateJoinTableChatroomsRssArticles < ActiveRecord::Migration[5.0]
  def change
    create_join_table :chatrooms, :rss_articles do |t|
      # t.index [:chatroom_id, :rss_article_id]
      # t.index [:rss_article_id, :chatroom_id]
    end
  end
end
