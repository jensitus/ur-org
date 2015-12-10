class Photo < ActiveRecord::Base
  belongs_to :micropost
  mount_uploader :picture, PictureUploader
  belongs_to :photo_gallery
  has_and_belongs_to_many :notices
end
