class LikesController < ApplicationController
  before_action :user_signed?
  before_action :find_post, only: %i(create destroy)
  before_action :find_like, only: :destroy

  def create
    @like = @post.likes.create user_id: current_user.id
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def destroy
    if @like.destroy
      respond_to :js
    end
  end

  private

  def user_signed?
    return if logged_in?

    flash[:danger] = t "not_yet_login"
    redirect_to root_path
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if @post

    flash[:danger] = t "post_not_exist"
    redirect_to root_path
  end

  def find_like
    @like = @post.likes.find_by id: params[:id]
    return if @like

    flash[:danger] = t "not_yet_liked"
    redirect_to root_path
  end
end
