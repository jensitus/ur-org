class MailAfterCommentJob < ActiveJob::Base
  queue_as :default

  def perform(comment_join_object)
    # Do something later
    puts "Do send the message later"
    puts comment_join_object
    puts u_a
    CommentMailer.comment_mail(comment_join_object)
  end
end