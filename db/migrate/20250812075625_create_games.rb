# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games, id: :bigint do |t|
      t.references :room, null: false, foreign_key: true, type: :bigint
      t.integer :set, null: false
      t.integer :turn, null: false
      t.datetime :next_turn_end_at
      t.timestamps
    end
  end
end
