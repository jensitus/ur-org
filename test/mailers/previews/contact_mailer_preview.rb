# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/confirmation
  def confirmation
    ContactMailer.confirmation
  end

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/inquiry
  def inquiry
    ContactMailer.inquiry
  end

end
