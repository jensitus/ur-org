class ReadPost < ApplicationRecord
  # has_one :micropost
  # belongs_to :user

  def self.update_read_post_as_read(entity_type_id, user_id, entity_type)
    puts entity_type_id
    puts user_id
    puts entity_type
    rps = ReadPost.where(entity_type_id: entity_type_id)
    rps.each do |rp|
      puts "ja? ja? ja? ja? ja? ja? ja? ja? ja?"
      puts rp.entity_type_id
      puts rp.user_id
      puts rp.entity_type
      if rp.user_id == user_id
        rp.update(read: true)
      end
    end
  end

end
