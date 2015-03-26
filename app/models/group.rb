class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :users, through: :group_memberships
  has_many :microposts
  has_many :group_maintainers

  acts_as_messageable

  def membership?(group, current_user)
    group.users.include? current_user
  end

  def maintainer?(group_id, user_id)
    s = 'select user_id from group_maintainers where group_id = :group_id and user_id = :user_id'
    gm = GroupMaintainer.where('group_id = :group_id and user_id = :user_id', group_id: group_id, user_id: user_id)
    gm
  end

end
