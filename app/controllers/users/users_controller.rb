class Users::UsersController < Users::BaseController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".create.signup_success"
      redirect_to root_path
    else
      flash[:danger] = t ".create.signup_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
