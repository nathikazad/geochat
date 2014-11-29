module Api
  module V1
      class ChatRoomsController < Api::ApiController
        before_action :set_chat_room, only: [:show, :update, :destroy, :add_user, :remove_user, :send_message, :retrieve_messages]

        api :GET,"/v1/chat_rooms", "Lists all chatrooms within proximity"
        param :latitude, Float, required:true
        param :longitude, Float, required:true
        param :radius, Integer, required:true
        param :offset, Integer, required:true
        param :size, Integer, required:true
        description "Notes \n Ordered by least distance first. \n It also has attribute radius which gives distance from chatroom \n if offset=0 and size=10, returns the first 10 results "
        def index
          @chat_rooms = ChatRoom.near([params[:latitude].to_f, params[:longitude].to_f], params[:radius].to_i).limit(100)
          @chat_rooms.each{|cr| cr.distance=cr.distance_to([params[:latitude].to_f, params[:longitude].to_f])}
          @chat_rooms=@chat_rooms.sort{|a,b| a.distance <=> b.distance}
          @chat_rooms=@chat_rooms[params[:offset].to_i,params[:size].to_i]
        end

        api :GET,"/v1/chat_room", "Show chatroom"
        param :id, Integer, "id of chatroom", required: true
        error  401, "Unauthorized if user is not a member of chatroom"
        description "Notes \n Returns last 20 messages and every user in the chatroom"
        example "{\n\t'id':1,\n\t'name':'coral',\n\t'latitude':45.35,\n\t'longitude':-120.56,\n\t'created_at':'2014-11-27T08:17:08.310Z',\n\t'updated_at':'2014-11-27T08:17:08.310Z',\n\t'users':[\n\t\t{'nick_name':'nate_dogz','id':1},\n\t\t{'nick_name':'fuck_dogz','id':2}],\n\t'messages':[\n\t\t{'content':'yo :)','user_id':1,'time':'2014-11-27T08:29:37.300Z'},\n\t\t{'content':'go fuck yourself','user_id':2,'time':'2014-11-27T08:29:47.795Z'},\n\t\t{'content':'thanks man','user_id':1,'time':'2014-11-27T18:46:40.237Z'}]\n}"
        def show
          unless @chat_room.users.include?(resource_owner)
            render json:{ status: :unauthorized }
          end
        end


        api :POST,"/v1/chat_rooms/create", "Create new chatroom"
        param :chat_room, Hash, :required => true, :action_aware => true do
          param :name, String, "Name of chatroom", :required => true
          param :latitude, Float, "Latitude", :required => true
          param :longitude, Float, "Longitude", :required => true
        end
        def create
          @chat_room = ChatRoom.new(chat_room_params)
          @chat_room.admin_id=resource_owner.id
          if @chat_room.save
            @chat_room.users << resource_owner
            render :show, status: :created, location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end

        api :PATCH, "/v1/chat_room", "Update Existing Chat Room"
        param :id, Integer, "Chat Room's Id", required:true
        param :chat_room, Hash, required: true, action_aware: true do
          param :name, String, "Name of chatroom"
          param :latitude, Float, "Latitude"
          param :longitude, Float, "Longitude"
          param :admin_id,  Integer, "Admin_id"
        end
        error  401, "Unauthorized if user is not admin of chatroom"
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

        api :DELETE, "/v1/chat_room", "Delete Existing Chat Room"
        param :id, Integer, "Chat Room's Id", required:true
        error  401, "Unauthorized if user is not admin of chatroom"
        def destroy
          if @chat_room.admin!=resource_owner
            render json: @chat_room.errors, status: :unauthorized
          else
            @chat_room.destroy
            format.json { head :no_content }
          end
        end

        #  POST /chat_room/add_user
        api :POST, "/v1/chat_room/add_user", "Add user to chat room"
        param :id, Integer, "Chat Room's Id", required:true
        error  422, "Unprocessable Entity"
        def add_user

          if (@chat_room.users << resource_owner).include?(resource_owner)
            render :show, status: :created, location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end


        api :DELETE, "/v1/chat_room/remove_user", "Remove user to chat room"
        param :id, Integer, "Chat Room's Id", required:true
        error  422, "Unprocessable Entity"
        def remove_user
          if (@chat_room.users.destroy(resource_owner).include?(resource_owner))
            render :show, status: :ok,  location: api_v1_chat_rooms_url
          else
            render json: @chat_room.errors, status: :unprocessable_entity
          end
        end


        #POST
        api :POST, "/v1/chat_room/send_message", "Send message to chat_room"
        error  401, "Unauthorized if user is not a member of chatroom"
        param :id, Integer, "Chat Room's Id", required:true
        param :message, Hash, required: true do
          param :content, String, "Content", required:true
        end
        def send_message
          if(@chat_room.users.include?(resource_owner))
            message=@chat_room.messages.new
            message.user=resource_owner
            message.content=params[:message][:content]
            if message.save
              render :show, status: :created, location: api_v1_chat_rooms_url
            else
              render json: @chat_room.errors, status: :unprocessable_entity
            end
          else
            render json:{ status: :unauthorized }
          end
        end

        api :GET, "/v1/chat_room/retrieve_messages", "retrieve messages since last retrieved message"
        error  401, "Unauthorized if user is not a member of chatroom"
        param :id, Integer, "Chat Room's Id", required:true
        param :index, Integer, "index of last message", required:true
        def retrieve_messages
          if(@chat_room.users.include?(resource_owner))
            @messages=@chat_room.messages_since(params[:index])
          else
            render json:{ status: :unauthorized }
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