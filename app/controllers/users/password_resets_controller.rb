class Users::PasswordResetsController < Users::BaseController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".notice_sent_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t ".not_found_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t(".cant_empty")
      render :edit
    elsif @user.update user_params.merge(reset_digest: nil)
      log_in @user
      flash[:success] = t "reset_success"
      redirect_to @user
    else
      flash[:danger] = t "reset_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::PASSWORD_RESET_PARAMS
  end

  def get_user
    @user = User.find_by email: params[:email].downcase
    return if @user

    flash[:errors] = t ".not_found_user"
    redirect_to new_password_reset_url
  end

  def valid_user
    return if @user&.authenticated?(:reset, params[:id])

    flash[:danger] = t ".valid_user"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".notice_link_die"
    redirect_to new_password_reset_url
  end
end
