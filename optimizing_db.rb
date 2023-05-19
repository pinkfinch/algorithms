# Fetch 10 blog posts and their comments
@posts = Post.limit(10)
@comments = @posts.map(&:comments).flatten

# Fetch 10 blog posts and their comments using eager loading
@posts = Post.includes(:comments).limit(10)
@comments = @posts.map(&:comments).flatten

users = User.all
users.each do |user|
  puts user.posts.count
end

#eager loading
users = User.includes(:posts)
users.each do |user|
  puts user.posts.count
end

posts = Post.all
posts.each do |post|
  puts post.comments.count
end

#eager loading
posts = Post.includes(:comments)
posts.each do |post|
  puts post.comments.count
end


## Rendering large views
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
end

# app/views/posts/index.html.erb
<h1>Posts</h1>

# <% @posts.each do |post| %>
#   <div class="post">
#     <%= post.title %>
#     <%= post.content %>
#   </div>
# <% end %>

#with pagination
# In your controller:
def index
  @items = Item.paginate(page: params[:page], per_page: 25)
end

# In your view:
<% @items.each do |item| %>
  # display item here
<% end %>

# <%= will_paginate @items %>

class User < ApplicationRecord
  has_many :posts
end

# Before: using the association to fetch posts for each user
users.each do |user|
  user.posts.each do |post|
    # do something with the post
  end
end

# After: using eager loading to fetch all posts for all users in a single query
users_with_posts = User.includes(:posts).where(id: users.map(&:id))
users_with_posts.each do |user|
  user.posts.each do |post|
    # do something with the post
  end
end

class Image < ApplicationRecord
  belongs_to :user
  validate :user_image_limit, on: :create

  private

  def user_image_limit
    if user.images.count >= 10
      errors.add(:base, "User has reached image upload limit")
    end
  end
end


#setting counter_cache
class User < ApplicationRecord
  has_many :images
end

class Image < ApplicationRecord
  belongs_to :user, counter_cache: true
  validate :user_image_limit, on: :create

  private

  def user_image_limit
    if user.images_count >= 10
      errors.add(:base, "User has reached image upload limit")
    end
  end
end


require 'memory_validator'

# Enable memory tracking
MemoryValidator.enable

# Your code here

# Disable memory tracking
MemoryValidator.disable

# Check for leaks
if MemoryValidator.leaked?
  puts "Memory leak detected!"
  puts MemoryValidator.report
end
