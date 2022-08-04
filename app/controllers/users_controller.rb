class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @booknew = Book.new
  end

  def show
    @user = User.find(params[:id])
    @booknew = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Your profile has been updated successfully."
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
