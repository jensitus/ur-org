class User < ActiveRecord::Base

  include Gravtastic
  gravtastic :secure => true,
             :filetype => :jpg,
             :size => 120

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  devise  :omniauthable, :omniauth_providers => [:twitter]

  validates_uniqueness_of :name
  #validates_presence_of :avatar
  #validates_integrity_of :avatar
  #validates_processing_of :avatar

  extend FriendlyId
  friendly_id :name, use: :slugged

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

  acts_as_messageable

  after_create :create_default_conversation

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.id).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def feed
    following_ids = 'select followed_id from relationships where follower_id = :user_id'
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
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

  private

  def create_default_conversation
    Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
  end

end
