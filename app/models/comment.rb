class Comment < ActiveRecord::Base
  belongs_to :user, :touch => true
  validates :user_id, presence: true
  validates :body, presence: true,
            :length => { maximum: 2480, :too_long => '%{count} characters is the maximum allowed'},
            :allow_nil => false

  has_one :answer
  has_one :micropost, through: :answer

end
