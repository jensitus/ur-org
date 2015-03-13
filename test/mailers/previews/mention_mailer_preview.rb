# Preview all emails at http://localhost:3000/rails/mailers/mention_mailer
class MentionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mention_mailer/comment_mention
  def comment_mention
    MentionMailer.comment_mention
  end

  # Preview this email at http://localhost:3000/rails/mailers/mention_mailer/micropost_mention
  def micropost_mention
    MentionMailer.micropost_mention
  end

end
