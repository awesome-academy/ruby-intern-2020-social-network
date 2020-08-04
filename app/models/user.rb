class User < ApplicationRecord
  has_one :intro_user, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :member_groups, dependent: :destroy
  has_many :fanpages, dependent: :destroy
  has_many :follow_fanpages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :topic_items, dependent: :destroy
  has_many :friend_requests_as_requestor, foreign_key: :requestor_id,
                                          class_name: FriendRequest.name,
                                          dependent: :destroy
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id,
                                         class_name: FriendRequest.name,
                                         dependent: :destroy
  has_many :active_relationships, class_name: FollowUser.name,
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: FollowUser.name,
                                   foreign_key: :followed_id,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
end
