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
    puts '********** mention it ************'
    puts mentionables.inspect
    puts mentioner.inspect
    @mentioner = mentioner
    mentionables.each do |mentionable|
      puts ''
      puts mentionable.inspect
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

      puts '???????????????????????????????????????'
      puts user.inspect
      puts '???????????????????????????????????????'
      puts mentioner.inspect
      ma = get_mentioner_asso(mentioner)
      puts ma.inspect
      if mentioner.micropost.nil?
        mentioner.photo.photo_gallery.users.each do |mentioner_user|
          post_writer = mentioner_user
          post = mentioner.photo
          MentionMailer.delay.comment_mention(user, mentioner, post_writer, post)
          puts '######## # # # # user ##################'
          puts user.inspect
          user.notify(
              'you were mentioned by ' + mentioner_user.name,
              cut_text[0].to_s + ' '  + cut_text[1].to_s + ' ... ' + "<br> <a href='/photos/#{mentioner.photo.id}'>ist-ur.org/photos/#{mentioner.photo.id}</a>! <small>Scroll down a bit!</small>"
          )
        end
      else
        user.notify(
            'you were mentioned by ' + mentioner.user.name,
            cut_text[0].to_s + ' '  + cut_text[1].to_s + ' ... ' + "<br> <a href='/#{mentioner.micropost.user.slug}/#{mentioner.micropost.id}'>ist-ur.org/#{mentioner.micropost.user.slug}/#{mentioner.micropost.id}</a>! <small>Scroll down a bit!</small>"
        )
        post_writer = mentioner.user
        post = mentioner.micropost
        puts post_writer.inspect
        puts post
        puts '############################################'
        MentionMailer.delay.comment_mention(user, mentioner, post_writer, post)
      end

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

  private

  def self.get_mentioner_asso(mentioner)
    if mentioner.micropost.nil?
      mentioner.photo.photo_gallery.users
    end
  end

end
