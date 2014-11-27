module Api
  module V1

      class UsersController < ApiController
      before_action :set_user, only: [ :update, :destroy, :show]


      def show
      end


      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
          if @user.update(user_params)
            render :show, status: :ok, location: api_v1_user_url
          else
            render json: @user.errors, status: :unprocessable_entity
          end
      end

      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        @user.destroy
          head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = resource_owner
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:nick_name, :fb_id, :fb_name)
        end
    end
  end
end