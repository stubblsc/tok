class Message < ApplicationRecord
  belongs_to :chatroom, inverse_of: :messages
  belongs_to :user, inverse_of: :messages

  enum type: [:user_post, :topic]

  self.inheritance_column = nil
end
