class Users::SessionsController < Users::BaseController
  before_action :load_topics

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password]).present?
      perform_log_in user
    else
      flash[:warning] = t ".login_fail"
      redirect_to signin_path
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = t ".logout_success"
    redirect_to signin_path
  end
end
