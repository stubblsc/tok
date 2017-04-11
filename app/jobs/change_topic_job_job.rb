class ChangeTopicJobJob < ApplicationJob
  queue_as :change_topic

  def perform(chatroom_id)
    chatroom = Chatroom.find_by(chatroom_id)
    chatroom.post_new_topic

    set(wait: 15.minutes).perform_later(chatroom_id)
  end
end
