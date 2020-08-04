class FollowFanpage < ApplicationRecord
  belongs_to :user
  belongs_to :fanpage
end
