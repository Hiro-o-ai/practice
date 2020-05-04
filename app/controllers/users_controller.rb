class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
    @bookn = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @bookn = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      redirect_to user_path(@user.id),notice: "your information updated successfully."
    else
      render :edit
    end
  end


  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def correct_user
    @user = User.find(params[:id])
    if  @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end
end


