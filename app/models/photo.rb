class Photo < ActiveRecord::Base
  belongs_to :micropost
  mount_uploader :picture, PictureUploader
  belongs_to :photo_gallery
end
