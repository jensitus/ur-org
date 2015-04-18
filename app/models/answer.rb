class Answer < ActiveRecord::Base

  belongs_to :micropost   #, :foreign_key => :micropost_id   #, class_name: 'Micropost'
  belongs_to :comment     #, :foreign_key => :comment_id     #, class_name: 'Micropost'

  after_commit :notify_everybody

  private

  def notify_everybody
    comm = micropost.comments
    co = []
    comm.each do |c|
      co << c.user
    end
    co << micropost.user
    recipients = co.uniq
    recipients.delete(comment.user)

    Mailboxer::Notification.notify_all(
        recipients,
        comment.user.name + ' commented:',
        '"' + comment.body + '"' + "<br><a href='/#{micropost.user.slug}/#{micropost.id}'>right here</a>",
        self
    )
  end

end
