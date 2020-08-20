class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_topics
    @topics = Topic.page(params[:page]).per Settings.per_page_topics
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_exist"
    redirect_to root_path
  end
end
