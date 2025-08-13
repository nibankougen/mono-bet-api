# frozen_string_literal: true

class Room < ApplicationRecord
  ACTION_CABLE_BROADCAST_NAME_PREFIX = "room_"

  has_many :users, dependent: :destroy
  has_many :games, dependent: :destroy

  validates :keyword, presence: true, uniqueness: true
  validates :max_users, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :status, presence: true, inclusion: { in: %w[waiting playing closed] }

  def action_cable_broadcast_name
    "#{ACTION_CABLE_BROADCAST_NAME_PREFIX}#{id}"
  end
end
