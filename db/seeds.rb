80.times do |n|
  content = Faker::Lorem.sentence
  post_id = rand(40..102)
  user_id = rand(1..16)
  parent_id = rand(116..195)
  Comment.create!(content: content,
    post_id: post_id,
    user_id: user_id)
end
