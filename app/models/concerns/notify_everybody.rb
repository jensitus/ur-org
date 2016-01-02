module NotifyEverybody
  extend ActiveSupport::Concern

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
        '"' + comment.body + '"' + "<br><a href='/#{micropost.user.slug}/#{micropost.id}'>ist-ur.org/#{micropost.user.slug}/#{micropost.id}</a> <small> maybe it is further below</small>",
        self
    )
  end

end