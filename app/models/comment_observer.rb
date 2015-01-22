class CommentObserver < ActiveRecord::Observer
  observe :answer
  def after_save(answer)

    ua = user_array(answer)

    ua.each do |u_a|
      puts u_a
      sleep 1
      CommentMailer.also_comment_mail( answer, u_a).deliver
    end

    if !ua.include?(answer.micropost.user.email)
      CommentMailer.comment_mail(answer).deliver
    end

  end

  private

  def user_array(answer)
    user_array = []
    also_answer = answer.micropost.comments

    also_answer.each do |aa|
      user_array << aa.user.email
    end

    user_array = user_array.uniq

  end

end
