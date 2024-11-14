class PostsController < ApplicationController
  def index
    posts = Post.all.includes(:comments, :user)
    render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def create
    post = Post.new(post_param)
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
