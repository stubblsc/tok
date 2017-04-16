class Category < ApplicationRecord
  has_many :chatrooms, inverse_of: :category
  has_and_belongs_to_many :rss_feeds, inverse_of: :categories

  after_create :create_chatroom

  private

  def create_chatroom
    self.chatrooms << Chatroom.create(name: self.name)
    self.save
  end
end
