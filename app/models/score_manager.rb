# frozen_string_literal: true

class ScoreManager
  MAX_SCORE = 999999999
  MIN_SCORE = -999999999

  TURN_SCORE_ARRAY_FROM_USERS_COUNT = {
    2 => [100, 200, 300, 100],
    3 => [100, 200, 100],
    4 => [100, 200, 300, 100],
    5 => [100, 200, 300, 200, 100],
    6 => [100, 200, 300, 400, 200, 100],
    7 => [100, 200, 300, 400, 300, 200, 100],
    8 => [100, 200, 300, 400, 500, 300, 200, 100],
    9 => [100, 200, 300, 400, 500, 400, 300, 200, 100],
    10 => [100, 200, 300, 400, 500, 600, 400, 300, 200, 100]
  }

  class << self
    def update_scores(game)
      bets = game.current_turn_bets

      if bets.empty?
        return
      end

      if bets.size == 1
        score = game.scores.find_or_initialize_by(game: game, user: bets[0].user, set: game.set)
        score.increment!(:score, increment_score_amount(game.room.max_users, game.turn))

        if score.score > MAX_SCORE
          score.update(score: MAX_SCORE)
        end
        return
      end

      bets.each do |bet|
        score = game.scores.find_or_initialize_by(game: game, user: bet.user, set: game.set)
        score.decrement!(:score, decrement_score_amount(bets.size))

        if score.score < MIN_SCORE
          score.update(score: MIN_SCORE)
        end
      end
    end

    private
    def increment_score_amount(max_users, turn)
      turn_score_array = TURN_SCORE_ARRAY_FROM_USERS_COUNT[max_users] || []
      turn_score_array[turn] || 0
    end

    def decrement_score_amount(bets_size)
      bets_size * 100
    end
  end
end