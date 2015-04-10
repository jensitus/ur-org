class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #Notifications.user('jens@ist-ur.org', 'New User Signed Up', user).deliver
    UserMailer.delay.registration_mail(user)
  end
end
