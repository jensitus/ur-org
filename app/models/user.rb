class User < ApplicationRecord

  include Gravtastic
  include PgSearch
  include UserObs

  gravtastic :secure => true,
             :filetype => :jpg,
             :size => 120

  mount_uploader :avatar, AvatarUploader

  multisearchable :against => [:name]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # devise  :omniauthable, :omniauth_providers => [:twitter]

  validates_uniqueness_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged, :sequence_separator => '_'

  has_many :conversations, :foreign_key => :sender_id
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :comments
  has_many :invite_counts
  has_many :invites, :through => :invite_counts
  has_many :group_memberships
  has_many :groups, through: :group_memberships
  has_many :group_maintainers
  has_one :custom_appearance
  has_many :read_posts

  has_and_belongs_to_many :photo_galleries

  accepts_nested_attributes_for :custom_appearance

  acts_as_messageable
  acts_as_mentionable
  acts_as_liker

  after_create :obs_create_the_user
  after_update :obs_update_the_user
  before_destroy :obs_destroy_the_user
  before_create :build_custom_appearance

  def normalize_friendly_id(string)
    super.gsub('-', '_')
  end

  def feed
    (get_the_microposts + get_the_gallery_activities + get_the_org_posts).uniq.sort_by(&:created_at).reverse
  end

  def visitors_feed
  (get_user_posts_for_visitors + get_gallery_for_visitors + get_org_posts_for_visitors).uniq.sort_by(&:created_at).reverse
  end

  def newsfeed
    (latest_photo_comments + following_activities + latest_comments_on_postings).sort_by(&:created_at).reverse
  end

  def get_the_org_posts
    # select * from microposts m, likes l, relationships r where m.id = likeable_id and r.follower_id = 4 and r.followed_id = l.liker_id
    Micropost.find_by_sql(['select m.* from microposts m, likes l, relationships r where m.id = likeable_id and r.follower_id = ? and r.followed_id = l.liker_id', id])
  end

  def get_the_microposts
    #following_ids = 'select followed_id from relationships where follower_id = :user_id'
    group_or_not = 'select group_id from group_memberships where user_id = :user_id'
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).where(group_id: nil)
  end

  def get_the_gallery_activities

    #PublicActivity::Activity.order('created_at desc').where(owner_id: self.following, owner_type: 'User')
    PublicActivity::Activity.where("owner_id in (#{following_ids}) OR owner_id = :user_id", user_id: id, owner_type: 'User').where("trackable_type = 'Notice'")
  end

  def following_activities
    PublicActivity::Activity.where("trackable_type = 'Relationship'")
  end

  def latest_photo_comments
    #following_ids = 'select followed_id from relationships where follower_id = :user_id'
    PublicActivity::Activity.where("owner_id in (#{following_ids}) OR owner_id = :user_id", user_id: id, owner_type: 'User').where("trackable_type = 'PhotoComment'")
  end

  def latest_comments_on_postings
    PublicActivity::Activity.where("owner_id in (#{following_ids}) OR owner_id = :user_id", user_id: id, owner_type: 'User').where("trackable_type = 'Comment'")
  end

  # connect a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # disconnect a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # return true if the current user is following the other user
  def following?(other_user)
    following.include?(other_user)
  end

  def mailboxer_email(object)
     if object.class == Mailboxer::Notification
       nil
     else
       email
     end
  end

  def no_emails(micropost_id)
    puts 'NO MAIL TODAY MY LOVE IS GONE AWAY ' + micropost_id.to_s
  end

  def send_devise_notification(notification, *args)
    if notification.to_s.match 'reset_password_instructions'
      ResetInstructionsJob.set(wait: 10.seconds).perform_later(self, *args)
    elsif notification.to_s.match 'invitation_instructions'
      logger.debug "notification == :invitation_instructions"
      logger.debug self
      InvitationInstructionJob.set(wait: 5.seconds).perform_later(self, *args)
    elsif notification.to_s.match 'confirmation_instructions'
      DeviseJob.set(wait: 5.seconds).perform_later(self, *args)
    end
  end

  private

  def following_ids
    following_ids = 'select followed_id from relationships where follower_id = :user_id'
  end

  def get_the_org
    org_ids = []
    following_ids.each do |f_id|
      org_ids << "select likeable_id from likes where liker_id = #{f_id}"
    end
    org_ids
  end

  def get_org_posts_for_visitors
    Micropost.find_by_sql(['select m.* from microposts m, likes l where m.id = likeable_id and liker_id = ?', id])
  end

  def get_user_posts_for_visitors
    self.microposts.where(group_id: nil)
  end

  def get_gallery_for_visitors
    PublicActivity::Activity.where("owner_id = :user_id", user_id: id, owner_type: 'User').where("trackable_type = 'Notice'")
  end

end
