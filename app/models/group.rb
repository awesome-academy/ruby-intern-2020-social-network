class Group < ApplicationRecord
  GROUP_PARAMS =
    %i(user_id intro_group avatar_group image_background_group).freeze

  belongs_to :user
  has_many :member_groups, dependent: :destroy
  has_one_attached :avatar_group
  has_one_attached :image_background_group
end
