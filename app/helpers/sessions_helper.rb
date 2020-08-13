module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if user_id = session[:user_id]
      @current_user || User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        user
      end
    end
  end

  def perform_log_in user
    params[:session][:remember_me] = if Settings.checkbox
                                       remember user
                                     else
                                       forget user
                                     end
    log_in user
    render :picker
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def logout
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
