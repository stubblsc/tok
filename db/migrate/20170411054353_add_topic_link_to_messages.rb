class AddTopicLinkToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :topic_link, :string
  end
end
