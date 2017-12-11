class MailAfterAlsoCommentJob < ActiveJob::Base
  queue_as :default

  def perform(comment_join_object, u_a)
    CommentMailer.also_comment_mail(comment_join_object, u_a)
  end
end
