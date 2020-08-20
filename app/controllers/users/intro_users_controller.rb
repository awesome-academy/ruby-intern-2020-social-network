class Users::IntroUsersController < Users::BaseController
  layout "layouts/application"

  before_action :find_info, only: %i(edit update)

  def create
    @intro_user = current_user.build_intro_user intro_user_params
    if @intro_user.save
      flash[:alert] = t "updated"
    else
      flash[:danger] = t "update_fails"
    end
    redirect_to users_user_path current_user
  end

  def edit; end

  def update
    if @intro_user.update intro_user_params
      flash[:alert] = t "updated"
    else
      flash[:danger] = t "update_fails"
    end
    redirect_to users_user_path current_user
  end

  private

  def intro_user_params
    params .require(:intro_user).permit IntroUser::INTRO_USER_PARAMS
  end

  def find_info
    @intro_user = current_user.intro_user
    return if @intro_user.present?

    flash[:alert] = t "not_yet_create_info"
    render :new
  end
end
