class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :users, through: :group_memberships

  def membership?(group, current_user)
    group.users.include? current_user
  end

end
