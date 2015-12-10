module CreateUpdateQueue
  extend ActiveSupport::Concern

  def trigger_the_create_queue
    PhotoGalleryCreateWorkers.perform_in(6.seconds, self.id)
  end

  def trigger_the_update_queue
    PhotoGalleryUpdateWorkers.perform_in(20.seconds, self.id)
  end

  def update_photo_gallery_notice(photo_gallery_id)
    p = PhotoGallery.find(photo_gallery_id)
    updating_user = User.find(p.last_updated_by_id)
    description = p.title
    @notice = p.notice
    if @notice.nil?
      count = 0
    else
      count = @notice.count
    end
    puts @notice.inspect
    # puts Time.now.to_time.to_i - @notice.updated_at.to_time.to_i
    if @notice.nil?
      create_photo_gallery_notice(p.id)
    else
      if Time.now.to_i - @notice.updated_at.to_time.to_i > 200
        count += 1
        puts count
        @notice.update!(user_id: p.last_updated_by_id, description: p.title, count: count)
        associate_some_photos(p)
        puts @notice.inspect
        @notice.create_activity :update, owner: updating_user
      else
        puts 'nothing to do'
      end
    end
  end

  def create_photo_gallery_notice(photo_gallery_id)
    p = PhotoGallery.find(photo_gallery_id)
    creating_user = User.find(p.last_updated_by_id)
    description = p.title
    create_notice(p.last_updated_by_id, description, p.id)
    associate_some_photos(p)
    @notice.create_activity :create, owner: creating_user
  end

  private

  def associate_some_photos(p)
    p.photos.each do |photo|
      if photo.created_at.to_date != Date.today
        puts 'na geh'
      elsif photo.created_at.to_date == Date.today
        puts 'jepp'
        @notice.photos << photo unless @notice.photos.include?(photo)
      end
    end
  end

  def create_notice(user_id, description, photo_gallery_id)
    @notice = Notice.create(
        user_id: user_id,
        description: description,
        photo_gallery_id: photo_gallery_id,
        count: 0
    )
  end

end