# Cheatsheet

## Models

```rb
class User < ApplicationRecord
  has_many :posts
  has_many :comments, thro: :posts # Error: Typo in 'through' keyword
  validates :name, presence: false # Error: Should be `true`
  validates :emai, uniqueness: true # Error: Typo in attribute name
end
```

```rb
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true, uniqueness: false # Error: `uniqueness` should be true
  validates :content, presence: true, length: { mininum: 10 } # Error: Typo in `minimum`
end
```

```ruby
class Comment < ApplicationRecord
  belongs_to :posts # Error: Should be singular `post`
  belongs_to :user
  validates :content, presence: true
end
```

## Controllers

```ruby
class UsersController < ApplicationController # Error: missing Api::V1::
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user, status: 200 # Error: No error handling for nil user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messags # Error: Typo in `full_messages`
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password) # Error: `password` doesn’t exist in schema
  end
end
```

```ruby
class PostsController < ApplicationController # Error: missing Api::V1::
  def index
    posts = Post.all.includes(:comments, :user) # Error: Incorrect includes for user
    render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def create
    post = Post.new(post_param) # Error: Typo in `post_params`
    if post.save
      render json: post, status: :created
    else
      render json: post.errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
```

```ruby
class CommentsController < ApplicationController
  def index
    comments = Comment.all
    render json: comment # Error: Typo in variable name
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def create
    comment = Comment.new(commnt_params) # Error: Typo in `comment_params`
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
```

## Routes

```ruby
# config/routes.rb
# creating unnecessary rout
Rails.application.routes.draw do
  resources :users
  resources :pots # Error: Typo, should be `posts`
  resources :comments
end
```