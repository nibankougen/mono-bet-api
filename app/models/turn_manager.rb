# frozen_string_literal: true

class TurnManager
  class << self
    def max_turn(game)
      game.room.max_users - 1
    end

    def all_turns_finished?(game)
      game.turn == max_turn(game)
    end
  end
end