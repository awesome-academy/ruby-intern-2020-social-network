class Group < ApplicationRecord
  belongs_to :user
  has_many :member_groups, dependent: :destroy
end
