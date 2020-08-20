class Users::UsersController < Users::BaseController
  layout "layouts/application", only: %i(show update)

  before_action :find_user, only: :show
  before_action :load_topics

  def show
    @intro_user = @user.intro_user
  end

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
    params[:user][:name] = current_user.name
    if current_user.update user_update_params
      redirect_to users_user_path
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
                                   [:id, :topic_id, :_destroy],
                                 images: []
  end
end
