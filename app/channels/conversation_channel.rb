class ConversationChannel < ApplicationCable::Channel

  def follow(data)
    stop_all_streams
    stream_from "conversation_#{data['user_id'].to_i}_messages"
  end

  def unfollow
    stop_all_streams
  end

end