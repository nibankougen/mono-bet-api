# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :set, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :score, presence: true, numericality: { only_integer: true }

  validates :game, presence: true
  validates :user, presence: true
end
