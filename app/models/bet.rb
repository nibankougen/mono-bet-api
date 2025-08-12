# frozen_string_literal: true

class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :turn, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user, presence: true
  validates :game, presence: true
end
