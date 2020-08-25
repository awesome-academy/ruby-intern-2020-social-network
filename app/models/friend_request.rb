class FriendRequest < ApplicationRecord
  belongs_to :requestor, class_name: User.name
  belongs_to :receiver, class_name: User.name

  enum status: {pending: 0, accepted: 1}
end
