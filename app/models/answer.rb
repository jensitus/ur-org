class Answer < ApplicationRecord

  include NotifyEverybody
  include CommObs

  belongs_to :micropost   #, :foreign_key => :micropost_id   #, class_name: 'Micropost'
  belongs_to :comment     #, :foreign_key => :comment_id     #, class_name: 'Micropost'

  after_commit :notify_everybody
  after_create :obs_the_comm

  private

  def self.observe_comment
    obs_the_comm(self)
  end

end
