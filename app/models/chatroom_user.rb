class ChatroomUser < ApplicationRecord
  belongs_to :chatroom, inverse_of: :chatroom_users
  belongs_to :user, inverse_of: :chatroom_users

  before_create :set_last_read

  def set_last_read
    self.last_read_at = Time.zone.now
  end
end
