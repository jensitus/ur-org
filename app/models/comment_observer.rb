class CommentObserver < ActiveRecord::Observer
  observe :answer
  def after_save(answer)
    CommentMailer.comment_mail(answer).deliver
  end
end
