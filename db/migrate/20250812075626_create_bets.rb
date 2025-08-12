# frozen_string_literal: true

class CreateBets < ActiveRecord::Migration[8.0]
  def change
    create_table :bets, id: :bigint do |t|
      t.references :game, null: false, foreign_key: true, type: :bigint
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.integer :set, null: false
      t.integer :turn, null: false
      t.timestamps
      t.index [:game_id, :set, :turn], name: "game_id_set_turn_index"
      t.index [:user_id, :set, :turn], name: "user_id_set_turn_index"
    end
  end
end
