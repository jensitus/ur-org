class ConfirmationInstructionsMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def confirmation_instructions(user, *args)
    puts '***** Mailer *****'
    puts user.inspect
    @user = user
    args = *args
    @token = args.first
    mail(:to => @user.email, :subject => "confirmation instructions")
  end

end
