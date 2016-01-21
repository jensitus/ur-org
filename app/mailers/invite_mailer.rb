class InviteMailer < ActionMailer::Base
  default from: 'info@ist-ur.org'

  def invite_mail(invite)
    @invite = invite
    mail to: invite.email, subject: 'Unglaublich: ' + invite.user.name + ' lädt dich ein'
  end
end
