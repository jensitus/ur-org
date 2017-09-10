class Photo < ActiveRecord::Base
  belongs_to :micropost
  mount_uploader :picture, PictureUploader
  belongs_to :photo_gallery

  has_and_belongs_to_many :notices
  has_many :photo_comments, dependent: :destroy
  has_many :comments, through: :photo_comments

  belongs_to :user

  before_destroy :delete_notice

  private

  def delete_notice
    puts 'delete the notice: ' + self.inspect
    n = self.notices
    n.each do |notice|
      activity = PublicActivity::Activity.find_by(trackable_id: notice.id)
      activity.delete
      notice.delete
    end
  end

end
