class CommentMailer < ActionMailer::Base
  default from: 'info@service-b.org'
  def comment_mail(answer)
    @answer = answer
    mail(:to => @answer.micropost.user.email, :subject => @answer.comment.user.name + ' wrote a comment')
  end
end
