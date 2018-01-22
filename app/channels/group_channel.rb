class GroupChannel < ApplicationCable::Channel
  # def subscribed
  #   stream_from "group_#{params['group-id']}_channel"
  # end
  #
  # def unsubscribed
  #
  # end
  #
  # def send_message
  #
  # end

  def follow(data)
    stop_all_streams
    stream_from "group_#{data['group_id']}_channel"
  end

  def unfollow
    stop_all_streams
  end
end