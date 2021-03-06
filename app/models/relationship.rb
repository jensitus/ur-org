class Relationship < ApplicationRecord
  include ObsRelationship
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}

  after_create :observe_the_relationship

end
