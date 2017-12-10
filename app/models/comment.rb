class Comment < ApplicationRecord
  include PublicActivity::Model
  #tracked owner: Proc.new{|controller, model| controller.current_user}
  belongs_to :user, :touch => true
  validates :user_id, presence: true
  validates :body, presence: true,
            :length => { maximum: 2480, :too_long => '%{count} characters is the maximum allowed'},
            :allow_nil => false

  has_one :answer
  has_one :micropost, through: :answer

  has_one :photo_comment
  has_one :photo, through: :photo_comment

  acts_as_mentioner

  auto_html_for :body do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => false)
    link :target => '_blank', :rel => 'nofollow'
    simple_format
  end

end
