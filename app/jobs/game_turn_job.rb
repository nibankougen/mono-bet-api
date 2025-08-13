# frozen_string_literal: true

class GameTurnJob < ApplicationJob
  queue_as :default

  def perform(game_id)
    game = Game.preload({ room: [:users], bets: [] }).find(game_id)
    
    ScoreManager.update_scores(game)

    if TurnManager.all_turns_finished?(game)
      game.update!(set: game.set + 1, turn: 0, next_turn_end_at: nil)
      ActionCable.server.broadcast(game.room.action_cable_broadcast_name, {
        type: 'set_finished',
        message: "Score: #{game.scores.map { |s| "#{s.user.name}: #{s.score}" }.join(', ')}",
      })
      return
    end

    next_turn_end_at = 5.seconds.from_now

    ActionCable.server.broadcast(game.room.action_cable_broadcast_name, {
      type: 'game_turn_end',
      message: "Turn end: #{game.turn}",
      next_turn_end_at: next_turn_end_at.iso8601
    })
    game.update!(turn: game.turn + 1, next_turn_end_at: next_turn_end_at)
    GameTurnJob.set(wait_until: next_turn_end_at).perform_later(game.id)
  end
end
