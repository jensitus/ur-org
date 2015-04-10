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
    elsif mentioner.class == Micropost
      MentionMailer.delay.micropost_mention(user, mentioner)
    end

  end

end
