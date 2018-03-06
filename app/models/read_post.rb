class ReadPost < ApplicationRecord
  has_one :micropost
  belongs_to :user
end
