class ReadPostJob < ApplicationJob
  include StaticData
  queue_as :default

  def perform(rp)
    puts " do the Read Post Job "
    r = ReadPost.find rp.id
    if r.read == false && r.user_notified == false && r.entity_type == StaticData::MAILBOXER_CONVERSATION
      ReadPostMailer.inform_about_new_message(r).deliver_now
    elsif r.read == false && r.entity_type == StaticData::MICROPOST
      puts "[info] it is an unread microposting, but currently we are doing nothing at this point"
    else
      puts "[info] everything is read now"
    end
  end

end
