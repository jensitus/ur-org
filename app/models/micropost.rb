class Micropost < ApplicationRecord
  include PgSearch
  include PublicActivity::Model
  tracked owner: Proc.new {|controller, model| controller.current_user}
  multisearchable :against => :content
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
            :length => {maximum: 10000, :too_long => '%{count} characters is the maximum allowed'},
            :allow_nil => false
  # validate :picture_size

  has_many :answers
  has_many :comments, through: :answers
  has_many :photos
  accepts_nested_attributes_for :photos

  has_one :group
  has_many :read_posts

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

  def no_emails(user_id)
    puts 'NO EMAILS IN MICROPOSTCONTROLLER ' + user_id.to_s
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
      recipients.delete(sender)
      puts group.inspect
      puts sender.inspect
      puts recipients.inspect
      recipients.each do |r|
        self.read_posts.create(micropost_id: self.id, user_id: r.id, read: false)
      end
    end
  end


end
