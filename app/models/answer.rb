class Answer < ActiveRecord::Base

  belongs_to :micropost   #, :foreign_key => :micropost_id   #, class_name: 'Micropost'
  belongs_to :comment     #, :foreign_key => :comment_id     #, class_name: 'Micropost'

end
