class User < ApplicationRecord
  belongs_to :room

  validates :name, presence: true
  validates :icon_id, presence: true
  validates :room, presence: true
end
