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

    context "with invalid attributes" do
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
        patch url, user: attributes_for(:user, nick_name: "new name"), :access_token => token.token
        user.reload
        expect(user.nick_name).to eq("new name")
      end  
    end
    context "with invalid attributes" do
      it "returns invalid response code" do  
        patch url
        expect(response.code).to eq("401")
      end
    end
  end
end