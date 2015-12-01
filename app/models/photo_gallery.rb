class PhotoGallery < ActiveRecord::Base
  has_many :photos
  accepts_nested_attributes_for :photos
  has_and_belongs_to_many :users
  validates :title, presence: true
end
