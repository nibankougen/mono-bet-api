class AddDefaultToScoreInScores < ActiveRecord::Migration[6.0]
  def change
    change_column_default :scores, :score, 0
  end
end
