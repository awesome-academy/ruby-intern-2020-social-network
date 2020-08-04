class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex
  USERS_PARAMS = %i(name email password password_confirmation
                    avatar image_background).freeze
  PASSWORD_RESET_PARAMS = %i(password password_confirmation).freeze

  attr_accessor :remember_token, :reset_token
  before_save :downcase_email

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
  has_many :topics, through: :topic_items
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

  accepts_nested_attributes_for :topic_items, allow_destroy: true

  has_one_attached :image_background
  has_one_attached :avatar
  has_many_attached :images

  validates :name, presence: true, length: {maximum: Settings.user.name_length}
  validates :email, presence: true,
                    length: {maximum: Settings.user.email_length},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: Settings.user.password_length},
                       on: :create

  scope :search, ->(name){where("name LIKE ?", "%#{name}%")}
  scope :by_ids, ->(ids){where(id: ids)}

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, _token
    send "#{attribute}_digest"
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update remember_digest: nil
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_send_at: Time.zone.now
  end

  def password_reset_expired?
    reset_sent_at < Settings.time_link_die.hours.ago
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private

  def downcase_email
    email.downcase!
  end
end
