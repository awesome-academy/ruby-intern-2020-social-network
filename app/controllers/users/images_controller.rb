class Users::ImagesController < Users::BaseController
  layout "layouts/application", only: :index

  before_action :find_user, only: :index

  def index
    @images = @user.images
  end

  def new
    @image = current_user.images.build
  end

  private

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user

    flash[:danger] = t "not_find_user"
    redirect_to root_path
  end
end
