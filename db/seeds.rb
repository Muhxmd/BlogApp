# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



# Only allow dummy data in development
unless Rails.env.development?
  raise "Dummy data can only be generated in development!"
end

puts "Creating dummy users..."

dummy_users = 10.times.map do |i|
  email = format("dummy-user-%02d@example.com", i + 1)

  User.find_or_create_by!(email: email) do |user|
    user.password = "DummyPass123!"
  end
end

puts "Creating dummy posts, comments, and likes..."

100.times do |i|
  user = dummy_users[i % dummy_users.length]
  title = format("Dummy Article %03d", i + 1)

  post = Post.find_or_create_by!(title: title, user: user) do |new_post|
    new_post.body = <<~BODY
      This is dummy article number #{i + 1}.

      This article is being used to test pagination, search,
      article display, comments, and likes in the Rails blog.

      #{("Extra sample content for testing long article layouts. " * (i % 8 + 1))}
    BODY
  end

  # Create between 1 and 3 comments per post.
  (1..(i % 3 + 1)).each do |n|
    commenter = dummy_users[(i + n) % dummy_users.length]

    Comment.find_or_create_by!(
      post: post,
      user: commenter,
      content: "Dummy comment #{n} on article #{i + 1}."
    )
  end

  # Create several likes from different dummy users.
  (1..(i % 7 + 2)).each do |n|
    liker = dummy_users[(i + n) % dummy_users.length]

    Like.find_or_create_by!(post: post, user: liker)
  end

  puts "Created/checked #{title}" if (i + 1) % 10 == 0
end

puts "Dummy data generation complete!"
puts "Users: #{User.count}"
puts "Posts: #{Post.count}"
puts "Comments: #{Comment.count}"
puts "Likes: #{Like.count}"