class PostsController < ApplicationController
  before_action :user_signed_in
  before_action :find_post, only: :destroy
  before_action :load_friend

  def index
    @post = Post.new
    @posts = Post.public_post
                 .not_by_group
                 .order_by_time.includes(:user).page(params[:page])
                 .per Settings.per_post
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new; end

  def create
    @post = current_user.posts.build post_params
    respond_to do |format|
      if @post.save
        format.js
      else
        format.html{redirect_to root_path}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html{redirect_to root_path}
      else
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS, images_post: []
  end

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = t "not_found_post"
    redirect_to root_path
  end
end
