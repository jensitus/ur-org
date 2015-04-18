class CommentObserver < ActiveRecord::Observer
  observe :answer
  def after_save(answer)

    ua = get_user_array(answer)
    ua.each do |u_a|
      CommentMailer.delay.also_comment_mail(answer, u_a)
    end
    #Mailboxer::Notification.notify_all(ua, 'new comment', answer.to_s, self)

    if !ua.include?(answer.micropost.user.email) && answer.comment.user.email != answer.micropost.user.email
      CommentMailer.delay.comment_mail(answer)
    end

  end

  private

  def get_user_array(answer)
    user_array = []
    also_answer = answer.micropost.comments
    also_answer.each do |aa|
      user_array << aa.user.email
    end
    user_array = user_array.uniq
    user_array.delete(answer.comment.user.email)
    user_array
  end

end
