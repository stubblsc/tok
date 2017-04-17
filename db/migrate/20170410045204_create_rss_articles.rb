class CreateRssArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :rss_articles do |t|
      t.references :rss_feed, foreign_key: true
      t.string :title
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
