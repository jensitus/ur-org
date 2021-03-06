class CommentMailer < ApplicationMailer
  default from: 'info@ist-ur.org'
  def comment_mail(answer)
    @answer = answer
    a = Scalpel.cut(@answer.comment.body)
    sub = the_subject_string(a)
    if @answer.is_a?(Answer)
      mail(:to => @answer.micropost.user.email,
           :subject => @answer.comment.user.name + ': ' + sub.join(' ') + ' ...' )
    elsif @answer.is_a?(PhotoComment)
      mail(:to => @answer.photo.user.email,
           :subject => @answer.comment.user.name + ': ' + sub.join(' ') + ' ...' )
    end
  end

  def also_comment_mail(answer, ua)
    puts ' ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  CommentMailer.also_comment_mail ~ ~ ~ ~ ~  ~  ~ ~ ~  '
    puts ua
    @answer = answer
    a = Scalpel.cut @answer.comment.body
    sub = the_subject_string(a)
    mail(:to => ua,
         subject: @answer.comment.user.name + ': ' +  sub.join(' ') + ' ...' )
  end

  private

  def the_subject_string(a)
    b = a[0].split
    sub = Array.new
    sub << b[0]
    sub << b[1] if !b[1].nil?
    sub << b[2] if !b[2].nil?
    puts sub.inspect
    sub
  end

end
