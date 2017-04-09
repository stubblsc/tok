class Message < ApplicationRecord
  belongs_to :chatroom, inverse_of: :messages
  belongs_to :user, inverse_of: :messages
end
