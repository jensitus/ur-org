class ContactMailJob < ApplicationJob
  queue_as :default

  def perform(contact)
    puts 'CONTACT:'
    puts contact.inspect
  end
end
