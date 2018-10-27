class ReadPostMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def inform_about_new_message(rp)
    @user = User.find rp.user_id
    @conversation = Mailboxer::Conversation.find rp.entity_type_id
    mail(to: @user.email, subject: 'new message in ' + @conversation.subject)
  end

end
