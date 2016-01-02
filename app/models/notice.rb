class Notice < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :photos
  belongs_to :photo_gallery
  include PublicActivity::Model
end
