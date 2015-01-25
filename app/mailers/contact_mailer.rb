class ContactMailer < ActionMailer::Base
  default from: 'info@ist-ur.org'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.confirmation.subject
  #
  def confirmation(contact)
    @greeting = 'Hi'
    @contact = contact
    mail to: contact.email
         # from: 'info@ist-ur.org'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.inquiry.subject
  #
  def inquiry(contact)
    @contact = contact
    @greeting = 'Hi'
    mail to: 'info@ist-ur.org',
         from: contact.email
  end
end
