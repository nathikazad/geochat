module Api
  module V1
      class ChatRoomsController < Api::ApiController
        before_action :set_chat_room, only: [:show, :update, :destroy, :add_user, :delete_user, :send_message]
        # GET /chat_rooms
        # GET /chat_rooms.json
        def index
          @chat_rooms = ChatRoom.near([params[:latitude].to_f, params[:longitude].to_f], params[:radius].to_i).limit(10)
        end


        def show
          i=1
        end

        # POST /chat_rooms
        # POST /chat_rooms.json
        def create
          @chat_room = ChatRoom.new(chat_room_params)
          @chat_room.admin_id=resource_owner.id
          if @chat_room.save
            render :show, status: :created, location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /chat_rooms/1
        # PATCH/PUT /chat_rooms/1.json
        def update
          if @chat_room.admin!=resource_owner
            render json: @chat_room.errors, status: :unauthorized
          else
            if @chat_room.update(chat_room_params)
              render :show, status: :ok, location: api_v1_chat_rooms_url
            else
              render json: @chat_room.errors, status: :unprocessable_entity
            end
          end
        end

        # DELETE /chat_rooms/1
        # DELETE /chat_rooms/1.json
        def destroy
          if @chat_room.admin!=resource_owner
            render json: @chat_room.errors, status: :unauthorized
          else
            @chat_room.destroy
            format.json { head :no_content }
          end
        end

        #  POST /chat_room/add_user
        def add_user

          if (@chat_room.users << resource_owner).include?(resource_owner)
            render :show, status: :created, location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end

        # DELETE /chat_room/delete_user
        def delete_user
          if (@chat_room.users.destroy(resource_owner).include?(resource_owner))
            render :show, status: :ok,  location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end


        #POST
        def send_message
          message=@chat_room.messages.new
          message.user=resource_owner
          message.content=params[:message][:content]
          if message.save
            render :show, status: :created, location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_chat_room
          @chat_room = ChatRoom.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def chat_room_params
          params.require(:chat_room).permit(:name, :latitude, :longitude, :radius, :admin_id, message:[:content])
        end
    end
  end
end