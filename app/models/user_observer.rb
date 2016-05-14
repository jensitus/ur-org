class UserObserver < ActiveRecord::Observer

  def after_create(user)
    #Notifications.user('jens@ist-ur.org', 'New User Signed Up', user).deliver
    UserMailer.delay.registration_mail(user)
  end

  def after_update(user)
    # puts '+ + + + + + + + + + + after_update + + + + + + + + + + +'
    if user.changes.include?(:invitation_accepted_at)
      # puts user.changes
      UserMailer.notice_when_invitation_accepted(user).deliver
    else
      # puts 'do nothin'
    end
  end

  def after_destroy(user)
    UserMailer.notice_when_user_destroyed(user).deliver
  end

end
