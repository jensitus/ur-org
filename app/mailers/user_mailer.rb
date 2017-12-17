class UserMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def registration_mail(user)
    @user = user
    mail(:to => 'jens@ist-ur.org', subject: 'new user!')
  end

  def notice_when_invitation_accepted(user)
    @user = user
    mail to: 'jens@ist-ur.org', subject: @user.name + ' accepted'
  end

  def notice_when_user_destroyed(user)
    @user = user
    mail to: 'jens@ist-ur.org', subject: @user.name + ' destroyed'
  end

end
