require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  let!(:application) { Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "http://app.com") }
  let!(:user) { create(:user) }
  let!(:token) { Doorkeeper::AccessToken.create! :application_id => application.id, :resource_owner_id => user.id }

  describe "GET #show" do
    let(:url) { "/api/v1/user" }
    
    context "with valid attributes" do
      it "returns the current user" do
        get url, user: attributes_for(:user), access_token: token.token
        expect(response.code).to eq("200")
        json = JSON.parse(response.body)
        expect(json['fb_name']).to eq user.fb_name
        expect(json['id']).to eq user.id
      end
    end

    context "with invalid credentials" do
      it "returns invalid response code" do
        get url
        expect(response.code).to eq("401")
      end
    end
  end

  describe "PATCH #update" do
    let(:url) { "/api/v1/user" }
    
    context "with valid attributes" do
      it "updates the users nickname with the specified parameter" do
        patch url, user: attributes_for(:user, nick_name: "new name"), access_token: token.token
        user.reload
        expect(user.nick_name).to eq("new name")
      end
      it "updates the users device token with the specified parameter" do
        patch url, user: attributes_for(:user, device_token: "somesecrettoken"), access_token: token.token
        user.reload
        expect(user.device_token).to eq("somesecrettoken")
      end 
    end

    context "with invalid credentials" do
      it "returns invalid response code" do  
        patch url
        expect(response.code).to eq("401")
      end
    end
  end

  describe "PATCH #update_connected" do
    let(:url) { "/api/v1/user/connected" }

    context "with valid attributes" do
      it "updates connected status of the user with valid paramter" do
        patch url, user: attributes_for(:user, connected: "true"), access_token: token.token
        user.reload
        expect(user.connected).to eq(true)
      end
    end

    context "with invalid attributes" do
      it "returns invalid response code with invalid credentials" do  
        patch url
        expect(response.code).to eq("401")
      end
      it "does not update the connected status with invalid parameter type" do
        patch url, user: attributes_for(:user, connected: "invalid"), access_token: token.token
        user.reload
        expect(user.connected).to eq(false)
      end
    end
  end

  describe "GET #chat_rooms" do
    let(:url) { "/api/v1/user/chat_rooms" }

    context "with valid atrtibutes" do 

      it "returns a valid response code" do
        get url, user: attributes_for(:user), access_token: token.token
        expect(response.code).to eq("200")
      end
      it "returns the chat rooms of the current user" do
        rooms = (1..3).map { create(:chat_room, admin_id: user.id)}
        get url, user: attributes_for(:user), access_token: token.token
        json = JSON.parse(response.body)
        expect(json.first["name"]).to eq(rooms.first.name)
        expect(json.second["latitude"]).to eq(rooms.second.latitude)
        expect(json.third["longitude"]).to eq(rooms.third.longitude)
      end
    end

    context "with invalid credentials" do
      it "returns invalid response code" do
        get url
        expect(response.code).to eq("401")
      end
    end
  end

  # describe "DELETE #destroy", type: :controller do
  #   let(:url) { "api/v1/user" }

  #   context "with valid attributes" do
  #     it "deletes the user" do
  #       binding.pry
  #       delete :destroy
  #       # delete :destroy, format: :json
  #       expect(:delete => url).to eq(false  )
  #       # user: attributes_for(:user), access_token: token.token
  #     end
  #   end
  #   context "with invalid attributes" do 
  #     it "returns invalid response code"
  #   end
  # end
end