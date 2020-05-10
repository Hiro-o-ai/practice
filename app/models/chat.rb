class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  # def template
  #   ApplicationController.renderer.render partial: 'rooms/chatlist', locals: { room: self }
  # end
end
