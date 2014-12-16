require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let!(:application) { Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "http://app.com") }
  let!(:user) { create(:user) }
  let!(:token) { Doorkeeper::AccessToken.create! :application_id => application.id, :resource_owner_id => user.id }

  describe "PATCH #update" do
    update = "/api/v1/user"
    
    context "with valid attributes" do
      it "updates the users nickname with the specified parameter" do
        patch update, user: attributes_for(:user, nick_name: "new name"), :access_token => token.token
        user.reload
        expect(user.nick_name).to eq("new name")
      end  
    end

    # context "with invalid attributes" do
    # end
  end
end