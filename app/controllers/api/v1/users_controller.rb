module Api
  module V1
      class UsersController < ApiController
        before_action :set_user, only: [ :update, :destroy, :show, :chat_rooms]

        def_param_group :user do
          param :user, Hash, :required => true, :action_aware => true do
            param :nick_name, String, "Nick name of the user", :required => true
            param :device_token, String, "Device Token of the current user", :required => true
          end
        end

        api :GET, "/v1/user", "Shows the current user"
        def show
        end

        api :PATCH, "/v1/user", "Update the current user"
        param_group :user
        def update
            if @user.update(user_params)
              render :show, status: :ok, location: api_v1_user_url
            else
              render json: @user.errors, status: :unprocessable_entity
            end
        end

        api :DELETE, "/v1/user", "Delete the current user"
        def destroy
          @user.destroy
            head :no_content
        end

        api :GET, "/v1/user/chat_rooms", "Lists the chat rooms of user"
        def chat_rooms
          @chat_rooms=@user.chat_rooms
        end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = resource_owner
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:nick_name, :device_token)
        end
    end
  end
end