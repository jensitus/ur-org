class Micropost < ActiveRecord::Base
  include PgSearch
  multisearchable :against => :content
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
            :length => { maximum: 10000, :too_long => '%{count} characters is the maximum allowed'},
            :allow_nil => false
  # validate :picture_size

  has_many :answers
  has_many :comments, through: :answers
  has_many :photos
  accepts_nested_attributes_for :photos

  has_one :group

  acts_as_mentioner
  acts_as_likeable

  after_commit :notify_user

  auto_html_for :content do
    html_escape
    image
    youtube(:width => '100%', :autoplay => false)
    link # :target => '_blank', :rel => 'nofollow'
    simple_format
  end




  private

  # Validates the size of an uploaded picture
  # def picture_size
  #   if picture.size > 5.megabytes
  #     errors.add(:picture, 'should be less than 5MB')
  #   end
  # end

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
