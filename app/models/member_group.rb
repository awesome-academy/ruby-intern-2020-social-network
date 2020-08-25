class MemberGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: {waiting: 0, approved: 1}
end
