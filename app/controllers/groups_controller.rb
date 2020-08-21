class GroupsController < ApplicationController
  before_action :find_group, only: :show

  def index
    @groups = current_user.groups.page(params[:page]).per Settings.per_group
  end

  def show
    @post = current_user.posts.build
    @posts = Post.post_group(@group.id).order_by_time.includes(:user)
                 .page(params[:page]).per Settings.per_post
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @group = current_user.groups.build
  end

  def create
    @group = current_user.groups.build group_params
    return unless @group.save

    flash[:alert] = t "create_group_success"
    render :show
  end

  private

  def group_params
    params.require(:group).permit Group::GROUP_PARAMS
  end

  def find_group
    @group = Group.find_by id: params[:id]
    return if @group

    flash[:danger] = t "not_find_group"
    redirect_to root_path
  end
end
