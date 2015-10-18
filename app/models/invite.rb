class Invite < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :email
end
