require 'rails_helper'

describe Api::V1::ChatRoomsController, type: :request do
  let!(:application) { Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "http://app.com") }
  let!(:user) { create(:user) }
  let!(:token) { Doorkeeper::AccessToken.create! :application_id => application.id, :resource_owner_id => user.id }

  describe "GET #index" do
    context "with valid attributes" do
      it "returns a valid reponse code"
      it "returns all the chatrooms within proximity"
    end
    context "with invalid attributes" do
      it "returns invalid response code"
    end
  end
end