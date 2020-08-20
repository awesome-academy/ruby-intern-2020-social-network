class IntroUser < ApplicationRecord
  INTRO_USER_PARAMS =
    %i(id gender birth_day marital_status address job school).freeze

  belongs_to :user

  validates :user_id, presence: true, uniqueness: true

  enum gender: {woman: 0, man: 1}
  enum marital_status: {relationship: 0, single: 1, get_married: 2}
end
