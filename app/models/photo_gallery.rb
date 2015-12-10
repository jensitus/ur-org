class PhotoGallery < ActiveRecord::Base
  include CreateUpdateQueue
  #tracked owner: ->(controller, model) { controller && controller.current_user}
  has_many :photos
  accepts_nested_attributes_for :photos
  has_and_belongs_to_many :users
  has_one :notice, dependent: :destroy
  validates :title, presence: true

  after_create :trigger_the_create_queue
  after_update :trigger_the_update_queue

end
