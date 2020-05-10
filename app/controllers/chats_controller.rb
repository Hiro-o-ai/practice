class ChatsController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    @chat = current_user.chats.new(chat_params)
    @chat.room_id = @room.id
    @chat.save
    #ActionCable.server.broadcast 'room_channel', room: @room.template
  end


  private
    def chat_params
      params.require(:chat).permit(:message)
    end
end
