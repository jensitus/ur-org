class Notice < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :photos
  belongs_to :photo_gallery, optional: true
  include PublicActivity::Model
end
