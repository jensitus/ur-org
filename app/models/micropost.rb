class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
            :length => { maximum: 2480, :too_long => '%{count} characters is the maximum allowed'},
            :allow_nil => false
  validate :picture_size

  has_many :answers
  has_many :comments, through: :answers

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end


end
