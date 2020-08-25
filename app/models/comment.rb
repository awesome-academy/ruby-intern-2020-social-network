class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(parent_id post_id user_id content).freeze

  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :sub_comments, class_name: Comment.name,
                          foreign_key: :parent_id, dependent: :destroy

  validates :content, presence: true, allow_blank: false

  scope :order_by_time, ->{order(created_at: :ASC)}
  scope :root_comments, ->{where parent_id: nil}
end
