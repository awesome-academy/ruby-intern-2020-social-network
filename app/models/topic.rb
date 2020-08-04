class Topic < ApplicationRecord
  has_many :topic_items, dependent: :destroy
end
