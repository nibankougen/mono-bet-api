# frozen_string_literal: true

class Rooms::UsersController < ApplicationController
  before_action :set_room

  def create
    @user = @room.users.create!(user_params)
    render json: @user, status: :created, serializer: UserSerializer
  end

  def update
    @user = @room.users.find(params[:id])
    @user.update!(user_params)
    render json: @user, status: :ok, serializer: UserSerializer
  end

  def destroy
    @user = @room.users.find(params[:id])
    @user.destroy!
    head :no_content
  end

  private
    def set_room
      @room = Room.find(params[:room_id])
    end

    def user_params
      params.require(:user).permit(:name, :icon_id)
    end
end
