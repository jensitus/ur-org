class CommentMailer < ActionMailer::Base
  default from: 'info@ist-ur.org'
  def comment_mail(answer)
    @answer = answer
    mail(:to => @answer.micropost.user.email, :subject => @answer.comment.user.name + ' wrote an answer')
  end

  def also_comment_mail(answer, ua)
    @answer = answer
    mail(:to => ua, subject: answer.comment.user.name +  ' also auch')
  end
end
