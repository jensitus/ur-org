class ReadPost < ApplicationRecord
  # has_one :micropost
  # belongs_to :user
  include ReadPostObs

  after_create :after_create_read_post

  def self.update_read_post_as_read(entity_type_id, user_id, entity_type)
    rps = ReadPost.where(entity_type_id: entity_type_id)
    rps.each do |rp|
      if rp.user_id == user_id
        rp.update(read: true)
      end
    end
  end

end
