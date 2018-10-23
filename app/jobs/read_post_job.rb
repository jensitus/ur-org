class ReadPostJob < ApplicationJob
  queue_as :default

  def perform(rp)
    puts " do the Read Post Job "
    u = User.find rp.user_id
    c = Mailboxer::Conversation.find rp.entity_type_id
    r = ReadPost.find rp.id
    if r.read == false && r.user_notified == false
      puts c.subject
    end

    read_post_collection = ReadPost.where(entity_type_id: rp.entity_type_id, user_id: rp.user_id)
    # puts read_post_collection.inspect
    read_post_collection.each do |r|
      if r.user_notified == false && r.read == false
        # puts "Wir werden eine Nachricht senden"
        # puts r.entity_type_id
      end
    end
  end

end
