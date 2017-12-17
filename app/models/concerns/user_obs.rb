module UserObs
  extend ActiveSupport::Concern

  def obs_create_the_user
    after_create(self)
  end

  def obs_update_the_user
    after_update(self)
  end

  def after_create(user)
    #Notifications.user('jens@ist-ur.org', 'New User Signed Up', user).deliver
    UserMailer.registration_mail(user).deliver_later
  end

  def after_update(user)
    # puts '+ + + + + + + + + + + after_update + + + + + + + + + + +'
    if user.changes.include?(:invitation_accepted_at)
      # puts user.changes
      UserMailer.notice_when_invitation_accepted(user).deliver_later
    else
      # puts 'do nothin'
    end
  end

  def after_destroy(user)
    UserMailer.notice_when_user_destroyed(user).deliver_later
  end

end