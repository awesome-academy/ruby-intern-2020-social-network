10.times do |n|
  content = "Post so #{n+1} test",
  private = 0,
  user_id = 1
  Post.create!(content: content,
    private: private,
    user_id: user_id)
end
