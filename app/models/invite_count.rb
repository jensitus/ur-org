class InviteCount < ActiveRecord::Base
  belongs_to :invite
  belongs_to :user
end
