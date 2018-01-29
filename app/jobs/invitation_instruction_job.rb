class InvitationInstructionJob < ApplicationJob
  queue_as :default

  def perform(user, *args)
    puts '****** Job *******'
    puts user.inspect
    InvitationInstructionsMailer.invitation_instructions(user, *args).deliver_now
  end
end
