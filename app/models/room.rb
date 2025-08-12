class Room < ApplicationRecord
  has_many :users

  validates :keyword, presence: true, uniqueness: true
  validates :max_users, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 11 }
  validates :status, presence: true, inclusion: { in: %w[waiting playing closed] }
end
