class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
    
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
    
      private
    
      def room_params
        params.require(:room).permit(:user_id, :other_attributes)
      end
end
