require 'scalpel'
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
      cut_text = Scalpel.cut(mentioner.body)
      MentionMailer.delay.comment_mention(user, mentioner)
      user.notify(
          'you were mentioned by ' + mentioner.user.name,
          cut_text[0].to_s + ' '  + cut_text[1].to_s + ' ... ' + "<br> <a href='/#{mentioner.micropost.user.slug}/#{mentioner.micropost.id}'>ist-ur.org/#{mentioner.micropost.user.slug}/#{mentioner.micropost.id}</a>! <small>Scroll down a bit!</small>"
      )
    elsif mentioner.class == Micropost
      #the_cutted_mention_text = Fillet_This::Fillet.cut_the_text(mentioner.content)
      cut_text = Scalpel.cut(mentioner.content)
      MentionMailer.delay.micropost_mention(user, mentioner)
      user.notify(
          mentioner.user.name + ' mentioned you in this posting:',
          cut_text[0] + ' ' + cut_text[1].to_s + ' ... ' + "<br> <a href='/#{mentioner.user.slug}/#{mentioner.id}'>ist-ur.org/#{mentioner.user.slug}/#{mentioner.id}</a>! It is so amazing"
      )
    end

  end

end
