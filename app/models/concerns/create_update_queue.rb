module CreateUpdateQueue
  extend ActiveSupport::Concern

  def trigger_the_create_queue
    PhotoGalleryCreateWorkers.perform_in(6.seconds, self.id)
  end

  def trigger_the_update_queue
    PhotoGalleryUpdateWorkers.perform_in(6.seconds, self.id)
  end

  def update_photo_gallery_notice(photo_gallery_id)
    p = PhotoGallery.find(photo_gallery_id)
    updating_user = User.find(p.last_updated_by_id)
    description = p.title
    create_notice(updating_user.id, description, photo_gallery_id)
    associate_some_photos(p)
    puts @notice.inspect
    @notice.create_activity :update, owner: updating_user
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
    pn = []
    p.notices.each do |n|
      n.photos.each do |photonotice|
        pn << photonotice
      end
    end
    pn.uniq!
    p.photos.each do |photo|
      if !pn.include?(photo)
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