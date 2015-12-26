module UsersHelper
  def conversation_interlocutor(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end

  def latest_photo_comments(user)
    user.latest_photo_comments.limit(10).order('created_at desc')
  end
end