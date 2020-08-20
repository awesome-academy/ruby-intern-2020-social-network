class Users::UsersController < Users::BaseController
  layout "layouts/application", only: %i(show update)
  layout "users/layouts/application", only: :new

  before_action :user_signed_in, only: %i(show update)
  before_action :find_user, only: %i(show edit)
  before_action :load_topics
  before_action :new_post, :get_intro, :check_current_user, only: :show

  def index
    if params[:name].blank?
      flash[:danger] = t "empty_field"
      redirect_to root_path
    else
      @users = User.search(params[:name])
                   .page(params[:page]).per Settings.per_user
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def show
    if check_current_user
      @personal_posts = current_user.posts.order_by_time
                                    .page(params[:page]).per Settings.per_post
    else
      @personal_posts = @user.posts.post_public("public_post")
                             .order_by_time.page(params[:page])
                             .per Settings.per_post
    end
    respond_to do |format|
      format.html
      format.js
    end
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

  def edit; end

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

  def check_current_user
    return true if @user.id == current_user.id
  end

  def get_intro
    @intro_user = @user.intro_user
  end

  def new_post
    @post = Post.new
  end
end
