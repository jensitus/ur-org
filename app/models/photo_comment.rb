class PhotoComment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :comment

  after_create

end
