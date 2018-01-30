class DeviseJob < ApplicationJob
  queue_as :default

  def perform(user, *args)
    puts '# Do something later'
    ConfirmationInstructionsMailer.confirmation_instructions(user, *args).deliver_now
    # devise_mailer.send(notification, self, *args).deliver_later
  end
end
