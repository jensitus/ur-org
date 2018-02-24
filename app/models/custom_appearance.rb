class CustomAppearance < ApplicationRecord
  belongs_to :user
  has_many :blogrolls
end
