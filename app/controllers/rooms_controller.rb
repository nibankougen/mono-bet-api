# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: [:update, :destroy]

  def create
    @room = Room.new(room_params)
    @room.save!
    render json: @room, status: :created, serializer: RoomSerializer
  end

  def show
    @room = Room.find(params[:id])
    render json: @room, status: :ok, serializer: RoomSerializer
  end

  def update
    @room.update!(room_params)
    render json: @room, status: :ok, serializer: RoomSerializer
  end

  def destroy
    @room.destroy!
    head :no_content
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:keyword, :max_users, :status)
    end
end
