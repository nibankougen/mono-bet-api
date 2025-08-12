# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :bigint do |t|
      t.references :room, null: false, foreign_key: true, type: :bigint
      t.string :name, null: false
      t.string :icon_id, null: false
      t.timestamps
    end
  end
end
