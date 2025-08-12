# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes :id
  attributes :max_users

  has_many :users, serializer: UserSerializer
end
