class InviteMailer < ActionMailer::Base
  default from: 'info@ist-ur.org'

  def invite_mail(invite)
    @invite = invite
    puts 'invite.inspect invite.inspect invite.inspect invite.inspect invite.inspect'
    puts invite.inspect
    mail to: invite.email, subject: 'Unglaublich: ' + invite.user.name + ' lädt dich ein'
  end
end
