# frozen_string_literal: true

class GameChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room_id])
    stream_from room.action_cable_broadcast_name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # ActionCable.server.broadcast("game_channel", { message: "A user has left the game." })
  end

  def start_game(data)
    console.log("Starting game in room: #{data['room_id']}")
    room = Room.find(data["room_id"])
    next_turn_end_at = 5.seconds.from_now

    game = room.games.create!(
      set: 0,
      turn: 0,
      next_turn_end_at: next_turn_end_at
    )
    ActionCable.server.broadcast(room.action_cable_broadcast_name, {
      type: 'game_started',
      message: "Game started in room: #{room.keyword}",
      game_id: game.id,
      next_turn_end_at: next_turn_end_at.iso8601
    })

    GameTurnJob.set(wait_until: next_turn_end_at).perform_later(game.id)
  end

  def bet(data)
    room = Room.find(data["room_id"])
    game = room.games.find(data["game_id"])
    user = User.find(data["user_id"])

    # return if game.set != data["set"].to_i || game.turn != data["turn"].to_i
    # return if game.bets.exists?(user: user, set: game.set)

    game.bets.create!(
      user: user,
      set: game.set,
      turn: game.turn
    )
    print("Bet created by user: #{user.name} in game: #{game.id}, set: #{game.set}, turn: #{game.turn}\n")

    ActionCable.server.broadcast(game.room.action_cable_broadcast_name, {
      type: 'bet_created',
      message: "Bet by: #{user.name}",
    })
  end
end
