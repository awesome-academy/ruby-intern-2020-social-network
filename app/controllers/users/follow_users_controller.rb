class Users::FollowUsersController < Users::BaseController
  before_action :user_signed_in
  before_action :find_user_create, only: :create
  before_action :find_user_destroy, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @user.followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user_create
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "user_not_exist"
    redirect_to root_path
  end

  def find_user_destroy
    @user = FollowUser.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_exist"
    redirect_to root_path
  end
end
