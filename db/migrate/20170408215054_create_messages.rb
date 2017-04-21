class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :chatroom, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :message_type
      t.text :body
      t.string :topic_url

      t.timestamps
    end
  end
end
