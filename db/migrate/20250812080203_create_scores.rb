# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[8.0]
  def change
    create_table :scores do |t|
      t.references :game, null: false, foreign_key: true, type: :bigint
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.integer :set
      t.integer :score
      t.timestamps

      t.index [:game_id, :set], name: "game_id_set_index"
      t.index [:user_id, :set], name: "user_id_set_index"
    end
  end
end
