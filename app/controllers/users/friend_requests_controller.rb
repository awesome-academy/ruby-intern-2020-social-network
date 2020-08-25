class Users::FriendRequestsController < Users::BaseController
  before_action :user_signed_in
  before_action :find_request, only: %i(update destroy)
  before_action :get_user, only: %i(create destroy)

  def create
    @friend_request = current_user.friend_requests_as_requestor
                                  .build receiver_id: params[:user_id],
                                         status: pending
    return unless @friend_request.save

    respond_to :js
  end

  def update
    @request.accepted!
    respond_to :js
  end

  def destroy
    respond_to do |format|
      if @request.destroy
        format.html{redirect_to root_path}
        format.js
      end
    end
  end

  private

  def find_request
    @request = FriendRequest.find_by id: params[:id]
    return if @request

    flash[:danger] = t "not_exist"
    redirect_to root_path
  end

  def get_user
    @user = User.find_by id: params[:user_id]
    return if @user

    flash[:danger] = t "user_not_exist"
    redirect_to root_path
  end
end
