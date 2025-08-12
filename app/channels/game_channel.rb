class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_room_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # ActionCable.server.broadcast("game_channel", { message: "A user has left the game." })
  end


end
