class CommentObserver < ActiveRecord::Observer
  observe :answer
  def after_save(answer)

    ua = get_user_array(answer)
    #byebug
    ua.each do |u_a|
      puts 'u_a **** u_a **** : '
      puts u_a
      sleep 1
      CommentMailer.also_comment_mail(answer, u_a).deliver
    end

    if !ua.include?(answer.micropost.user.email) && answer.comment.user.email != answer.micropost.user.email
      puts 'answer.micropost.user.email: '
      puts answer.comment.user.email
      puts answer.micropost.user.email
      CommentMailer.comment_mail(answer).deliver
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
    puts user_array
    user_array
  end

end
