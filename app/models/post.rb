class Post < ApplicationRecord
  POST_PARAMS = %i(content private).freeze
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :fanpage, optional: true
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :images_post

  scope :order_by_time, ->{order(created_at: :DESC)}
  scope :post_public, ->(private){where private: private}

  enum private: {public_post: 0, private_post: 1}
end
