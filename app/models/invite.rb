class Invite < ActiveRecord::Base
  has_one :invite_count
  has_one :user, through: :invite_count
  validates_uniqueness_of :email
  validates_format_of :email, with: /@/

  after_commit :invite_someone

  private

  def invite_someone
    #puts '**********************************~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    #puts self.inspect
    # puts '**********************************~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts '**********************************~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    InviteMailer.delay.invite_mail(self).deliver
  end

end
