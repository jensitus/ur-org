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

  has_one :group

  acts_as_mentioner
  acts_as_likeable

  after_commit :notify_user

  private

  # Validates the size of an uploaded picture
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end

  def notify_user
    if !group_id.nil?
      sender = User.find user_id
      recipients = []
      group = Group.find(group_id)
      group.users.each do |gu|
        recipients << gu
      end
      Mailboxer::Notification.notify_all(
          recipients,
          sender.name + ' schrieb in ' + group.name + ':' ,
          content + "<br><a href='/groups/#{group_id}'>view</a>",
          self
      )
    end
  end


end
