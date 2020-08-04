class SuggestFriendsController < ApplicationController
  before_action :load_friend

  def index
    topics = current_user.topics.includes :users
    suggest_friend_ids = TopicItem.where(topic_id: topics.pluck(:id)).pluck :user_id
    suggest_friend_ids = suggest_friend_ids.flatten.uniq
                                           .shuffle
                                           .difference @friends.pluck(:id)
    @suggest_friends = User.by_ids suggest_friend_ids
  end
end
