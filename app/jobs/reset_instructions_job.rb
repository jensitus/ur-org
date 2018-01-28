class ResetInstructionsJob < ApplicationJob
  queue_as :default

  def perform(user, *args)
    ResetPasswordInstructionsMailer.reset_password_instructions(user, *args).deliver_now
  end
end
