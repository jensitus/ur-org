class PhotoGalleryUpdateWorkers
  include Sidekiq::Worker
  include CreateUpdateQueue

  def perform(photo_gallery_id)
    puts '**********  photo_gallery_id     *****************'
    puts photo_gallery_id
    update_photo_gallery_notice(photo_gallery_id)

  end

end