class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :take_slot]

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def take_slot
    @room = Room.find(params[:id])
    slot_number = params[:slot_number].to_i

    if @room.take_slot(slot_number, current_user)
      redirect_to @room, notice: "Slot #{slot_number} taken successfully."
    else
      redirect_to @room, alert: "Slot #{slot_number} is already taken or invalid."
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
