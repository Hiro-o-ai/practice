class RoomsController < ApplicationController
  # def create
  #   @room = Room.create
  #   @user_room1 = UserRoom.create(room_id: @room.id, user_id: current_user.id)
  #   @user_room2 = UserRoom.create(user_room_params).merge(:room_id => @room.id))
  #   redirect_to rooms_path(@room)
  # end

  # def show
  #   @room = Room.find(params[:id])
  #   if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
  #     @chats = @room.chats
  #     @chat = Chat.new
  #     @use_room = @room.user_rooms
  #   else
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  # def create
  #   @room = Room.create(:name => "DM")
  #   @entry1 = UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
  #   @entry2 = UserRoom.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
  #   redirect_to room_path(@room.id)
  # end

  def show
    @chat = Chat.new
    @room = Room.find(params[:id])
    if UserRoom.where(:user_id => current_user.id, :room_id => @room.id).present?
      @chats = @room.chats
      @entries = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "chat")
    @entry1 = UserRoom.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = UserRoom.create((user_room_params).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end

  private
  def user_room_params
    params.require(:user_room).permit(:user_id, :room_id)
  end

end
