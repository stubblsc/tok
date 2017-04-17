class CreateRssFeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :rss_feeds do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :language
      t.datetime :pub_date
      t.datetime :last_build_date

      t.timestamps
    end
  end
end
