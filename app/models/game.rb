# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :room
  has_many :scores, dependent: :destroy
  has_many :bets, dependent: :destroy

  validates :set, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :turn, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :room, presence: true
end
