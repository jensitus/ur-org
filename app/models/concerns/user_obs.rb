module UserObs
  extend ActiveSupport::Concern

  def obs_create_the_user
    what_user_action = 'create'
    UserJob.set(wait: 5.seconds).perform_later(self, what_user_action)
  end

  def obs_update_the_user
    what_user_action = 'update'
    # UserJob.set(wait: 5.seconds).perform_later(self, what_user_action)
  end

  def obs_destroy_the_user
    what_user_action = 'destroy'
    UserJob.set(wait: 5.seconds).perform_later(self, what_user_action)
  end

  def after_create(user)
    #Notifications.user('jens@ist-ur.org', 'New User Signed Up', user).deliver
    UserMailer.registration_mail(user).deliver_now
  end

  def after_update(user)
    # puts '+ + + + + + + + + + + after_update + + + + + + + + + + +'
    if user.changes.include?(:invitation_accepted_at)
      # puts user.changes
      UserMailer.notice_when_invitation_accepted(user).deliver_now
    else
      # puts 'do nothin'
    end
  end

  def after_destroy(user)
    UserMailer.notice_when_user_destroyed(user).deliver_now
  end

end