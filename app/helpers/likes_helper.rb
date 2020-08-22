module LikesHelper
  def is_liked? post
    current_user.likes.find_by post_id: post.id
  end
end
