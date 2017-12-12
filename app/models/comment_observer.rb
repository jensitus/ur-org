class CommentObserver < ActiveRecord::Observer
  observe :answer, :photo_comment

  def after_save(comment_join_object)

    ua = get_user_array(comment_join_object)
    puts 'ua: ' + ua.inspect
    ua.each do |u_a|
      puts 'u_a ' + u_a
      CommentMailer.also_comment_mail(comment_join_object, u_a).deliver_later
      # MailAfterAlsoCommentJob.perform_later(comment_join_object, u_a)
    end

    if comment_join_object.is_a?(Answer)
      if !ua.include?(comment_join_object.micropost.user.email) && comment_join_object.comment.user.email != comment_join_object.micropost.user.email
        en = EmailNotification.find_by(micropost_id: comment_join_object.micropost.id, user_id: comment_join_object.micropost.user.id)
        if en.nil? || en.emails == true
          puts 'answer: ' + comment_join_object.inspect
          CommentMailer.comment_mail(comment_join_object).deliver_later
          # MailAfterCommentJob.perform_later(comment_join_object)
        end
      end
    elsif comment_join_object.is_a?(PhotoComment)
      if !ua.include?(comment_join_object.photo.user.email) && comment_join_object.comment.user.email != comment_join_object.photo.user.email
        puts 'answer: ' + comment_join_object.inspect
        CommentMailer.comment_mail(comment_join_object).deliver_later
        # MailAfterCommentJob.perform_later(comment_join_object)
      end
    end

  end

  private

  def get_user_array(comment_join_object)
    user_array = []
    if comment_join_object.is_a?(Answer)
      also_answer = comment_join_object.micropost.comments
      also_answer.each do |aa|
        user_array << aa.user
      end
    elsif comment_join_object.is_a?(PhotoComment)
      also_answer = comment_join_object.photo.comments
      also_answer.each do |aa|
        user_array << aa.user
      end
    end
    user_array = user_array.uniq
    user_array.delete(comment_join_object.comment.user)
    email_array = []
    user_array.each do |user|
      email_notification = EmailNotification.find_by(micropost_id: comment_join_object.micropost.id, user_id: user.id)
      if email_notification.nil? || email_notification.emails == true
        email_array << user.email
      end
    end
    email_array
  end

end
