class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @bookn = Book.new
    @books = @user.books
    @currentUserEntry = UserRoom.where(user_id: current_user.id)
    @userEntry=UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = UserRoom.new
      end
    end
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

  def following
    user  = User.find(params[:id])
    @users = user.following
  end

  def followers
    user  = User.find(params[:id])
    @users = user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end
  def correct_user
    @user = User.find(params[:id])
    if  @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end
end


