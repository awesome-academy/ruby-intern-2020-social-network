class Topic < ApplicationRecord
  has_many :topic_items, dependent: :destroy
  has_many :users, through: :topic_items
end
