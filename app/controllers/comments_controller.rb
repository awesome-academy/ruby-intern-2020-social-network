class CommentsController < ApplicationController
  before_action :user_signed_in

  def new
    @comment = Comment.find_by id: params[:comment_id]
    @post = @comment.post
    respond_to :js
  end

  def create
    @comment = current_user.comments.build comment_params
    @post = @comment.post
    respond_to do |format|
      if @comment.save
        format.html{redirect_to root_path}
      else
        format.html{redirect_to root_path, alert: t("not_save")}
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end
end
