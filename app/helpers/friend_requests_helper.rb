module FriendRequestsHelper
  include SessionsHelper

  def accepted
    FriendRequest.statuses[:accepted]
  end

  def pending
    FriendRequest.statuses[:pending]
  end

  def receiver_pending
    @receivers = current_user.friend_requests_as_requestor
                             .pending
  end

  def requestor_pending
    @requestors = current_user.friend_requests_as_receiver
                              .pending
  end

  def check_user_receiver user
    receiver_pending.pluck(:receiver_id).include? user.id
  end

  def check_user_requestor user
    requestor_pending.pluck(:requestor_id).include? user.id
  end

  def receiver_accepted
    @friends_to = current_user.friend_requests_as_requestor
                              .accepted
  end

  def requestor_accepted
    @friends_from = current_user.friend_requests_as_receiver
                                .accepted
  end

  def get_receiver_id
    receiver_accepted.pluck :receiver_id
  end

  def get_requestor_id
    requestor_accepted.pluck :requestor_id
  end

  def friend
    get_receiver_id
    get_requestor_id

    get_receiver_id.push(*get_requestor_id)
  end

  def find_request_to user
    FriendRequest.find_by requestor_id: current_user.id,
                          receiver_id: user.id, status: pending
  end

  def find_request_from user
    FriendRequest.find_by requestor_id: user.id,
                          receiver_id: current_user.id, status: pending
  end

  def find_friend user
    if get_receiver_id.include? user.id
      FriendRequest.find_by requestor_id: current_user,
                            receiver_id: user.id, status: accepted
    elsif get_requestor_id.include? user.id
      FriendRequest.find_by requestor_id: user.id,
                            receiver_id: current_user, status: accepted
    end
  end
end
