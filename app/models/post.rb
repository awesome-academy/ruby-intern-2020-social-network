class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  belongs_to :fanpage, optional: true
  has_many :likes, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :comments, dependent: :destroy
end
