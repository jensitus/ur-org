class Group < ApplicationRecord
  has_many :group_memberships
  has_many :users, through: :group_memberships
  has_many :microposts
  has_many :group_maintainers
  has_many :maintainers, through: :group_maintainers

  acts_as_messageable

  def membership?(group, current_user)
    group.users.include? current_user
  end

  def maintainer(group_id, current_user_id)
    if GroupMaintainer.where(group_id: group_id, user_id: current_user_id).first.nil?
      false
    else
      true
    end
  end

  def public_groups

  end

  private

  def get_public_groups
    public = where(private: false)
    userG = current_user.group

  end

end
