class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messags
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
