class ContactMailJob < ApplicationJob
  queue_as :default

  def perform(contact)
    puts 'CONTACT:'
    puts contact.inspect
    ContactMailer.confirmation(contact).deliver_now
    ContactMailer.inquiry(contact).deliver_now
  end
end
