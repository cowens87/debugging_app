class CommentsController < ApplicationController
  def index
    comments = Comment.all
    render json: comment
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def create
    comment = Comment.new(commnt_params)
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
