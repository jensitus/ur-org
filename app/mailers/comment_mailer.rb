class CommentMailer < ActionMailer::Base
  default from: 'info@service-b.org'
  def comment_mail(answer)
    @answer = answer
    mail(:to => @answer.micropost.user.email, :subject => @answer.comment.user.name + ' wrote a comment')
  end

  def also_comment_mail(answer, ua)
    @answer = answer
    mail(:to => ua, subject: answer.comment.user.name +  ' hat auch noch so einen verdammten kommentar geschrieben')
  end
end
