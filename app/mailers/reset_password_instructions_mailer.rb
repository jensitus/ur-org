class ResetPasswordInstructionsMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def reset_password_instructions(user, *args)
    @user = user
    args = *args
    @token = args.first
    mail(:to => @user.email, :subject => 'reset password instructions')
  end

end
