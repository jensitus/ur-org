class MentionMailJob < ApplicationJob
  queue_as :default

  def perform(user, mentioner)
    # Do something later
    Mention.inform_the_mentionable(user, mentioner)
  end
end
