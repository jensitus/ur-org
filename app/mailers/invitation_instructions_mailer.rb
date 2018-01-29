class InvitationInstructionsMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def invitation_instructions(user, *args)
    puts '***** Mailer *****'
    puts user.inspect
    @user = user
    args = *args
    @token = args.first
    mail(:to => @user.email, :subject => "you've been invited")
  end
end
