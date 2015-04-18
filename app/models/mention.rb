class Mention < Socialization::ActiveRecordStores::Mention

  def self.get_the_mention(men)
    mention = []
    men.split.each do |m|
      if m.include? '@'
        mention << m.delete('.,!?=+*#:;"§$%&/\()').gsub(/\s/, '').delete("'").gsub(/@/, '')
      end
    end
    mention
  end

  def self.mention_it(mentionables, mentioner)
    @mentioner = mentioner
    mentionables.each do |mentionable|
      user = User.find_by_slug mentionable
      mentioner.mention! user
      inform_the_mentionable(user, mentioner)
    end
  end

  def self.inform_the_mentionable(user, mentioner)
    user
    mentioner
    if mentioner.class == Comment
      MentionMailer.delay.comment_mention(user, mentioner)
      user.notify(
          'you were mentioned by ' + mentioner.user.name,
          mentioner.body + "<br> <a href='/#{mentioner.micropost.user.slug}/#{mentioner.micropost.id}'>click this</a>!"
      )
    elsif mentioner.class == Micropost
      MentionMailer.delay.micropost_mention(user, mentioner)
      user.notify(
          mentioner.user.name + ' mentioned you in this posting:',
          mentioner.content + "<br> <a href='/#{mentioner.user.slug}/#{mentioner.id}'>right here</a>! It is so amazing"
      )
    end

  end

end
