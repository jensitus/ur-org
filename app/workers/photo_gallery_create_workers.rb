class PhotoGalleryCreateWorkers
  include Sidekiq::Worker
  include CreateUpdateQueue

  def perform(photo_gallery_id)
    create_photo_gallery_notice(photo_gallery_id)
  end
end