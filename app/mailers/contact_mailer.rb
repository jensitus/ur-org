class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.confirmation.subject
  #
  def confirmation(contact)
    @greeting = 'Hi'
    @contact = contact
    mail to: contact.email,
         from: 'info@service-b.org'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.inquiry.subject
  #
  def inquiry(contact)
    @contact = contact
    @greeting = 'Hi'
    mail to: 'info@service-b.org',
         from: contact.email
  end
end
