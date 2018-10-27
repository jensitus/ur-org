class ReadPostJob < ApplicationJob
  queue_as :default

  def perform(rp)
    puts " do the Read Post Job "
    r = ReadPost.find rp.id
    if r.read == false && r.user_notified == false
      ReadPostMailer.inform_about_new_message(r).deliver_now
    else
      puts "everything is read now"
    end
  end

end
