class MentionMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mention_mailer.comment_mention.subject
  #
  def comment_mention(user, mentioner, post_writer, post)
    puts 'now we are in MentionMailer class * * * * * * ** * * * * * *'
    @greeting = 'Hi'
    @mentioner = mentioner
    @user = user
    @post_writer = post_writer
    @post = post
    mail to: user.email, :subject => '[ur.org] ' + mentioner.user.name + ' mentioned you'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mention_mailer.micropost_mention.subject
  #
  def micropost_mention(user, mentioner) #(mention)

    puts ' ~ ~ ~ ~ ~ ~ ~  micropost_mention  ~ ~ ~ ~ ~ ~ ~ ~ ~'

    @mentioner = mentioner
    @user = user
    @greeting = 'Hi'
    @writer = mentioner.user

    mail to: user.email, :subject => 'hi ' + user.name + ', ' + @writer.name + ' mentioned you'
  end
end
