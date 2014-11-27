module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    doorkeeper_for :all

    def resource_owner
      return User.find(doorkeeper_token.resource_owner_id)
    end

    def is_admin?
      render json:{error:"Unauthorized"},  status: :unauthorized unless resource_owner.is_admin?
    end
  end
end