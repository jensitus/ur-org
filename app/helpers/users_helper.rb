module UsersHelper
  def conversation_interlocutor(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end

  def newsfeed

  end

  def sidebar_activities(user)
    user.newsfeed.first(10)
  end

  def latest_photo_comments(user)
    user.latest_photo_comments.limit(10).order('created_at desc')
  end

  def latest_posting_comments(user)
    user.latest_comments_on_postings.limit(10).order('created_at desc')
  end

end