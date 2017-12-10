class InviteCount < ApplicationRecord
  belongs_to :invite
  belongs_to :user
end
