class UserMailer < ActionMailer::Base
  default from: 'info@ist-ur.org'

  def registration_mail(user)
    @user = user
    mail(:to => 'jens@ist-ur.org', subject: 'new user!')
  end
end
