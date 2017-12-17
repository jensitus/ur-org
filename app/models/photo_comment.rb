class PhotoComment < ApplicationRecord
  belongs_to :photo
  belongs_to :comment, dependent: :destroy

  #include PhotoCommentObserver
  include PublicActivity::Model
  include CommObs
  #tracked owner: Proc.new{|controller, model| controller.current_user}

  # after_create :something_coming
  after_create :obs_the_comm

end
