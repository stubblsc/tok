class Message < ApplicationRecord
  belongs_to :chatroom, inverse_of: :messages
  belongs_to :user, inverse_of: :messages, optional: true

  enum message_type: [:user_post, :topic]

  validates :body, presence: true
  validates :message_type, presence: true
  validates :user_id, presence: true, if: :is_user_post?

  scope :user_posts, -> {where(message_type: :user_post)}
  scope :topics,     -> {where(message_type: :topic)}

  def is_user_post?
    message_type == 'user_post'
  end

  def is_topic?
    message_type == 'topic'
  end
end
