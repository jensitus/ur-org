class Invite < ApplicationRecord
  has_one :invite_count
  has_one :user, through: :invite_count
  validates_uniqueness_of :email
  validates_format_of :email, with: /@/

  after_commit :invite_someone

  private

  def invite_someone
    InviteMailer.invite_mail(self).deliver_later
  end

end
