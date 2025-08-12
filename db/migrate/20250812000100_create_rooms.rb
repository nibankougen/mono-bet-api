# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms, id: :bigint do |t|
      t.string :keyword, null: false, index: { unique: true }
      t.integer :max_users, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
