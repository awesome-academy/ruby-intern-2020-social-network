class Users::UsersController < Users::BaseController
  before_action :find_user, only: :update
  before_action :load_topics

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

  def update
    params[:user][:name] = @user.name
    if @user.update user_update_params
      render "layouts/application", layout: false
    else
      flash[:danger] = t "update_not_suscess"
      redirect_to topics_path
    end
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def user_update_params
    params.require(:user).permit User::USERS_PARAMS,
                                 topic_items_attributes:
                                   [:id, :topic_id, :_destroy]
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_exist"
    redirect_to root_path
  end
end
