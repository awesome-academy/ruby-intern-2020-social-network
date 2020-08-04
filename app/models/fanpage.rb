class Fanpage < ApplicationRecord
  belongs_to :user
  has_many :follow_fanpages, dependent: :destroy
end
