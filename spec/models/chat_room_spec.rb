require 'rails_helper'

describe ChatRoom do 
  it "has a valid factory" do
    expect(create(:chat_room)).to be_valid
  end

  it "is valid with name, latitude, longitude, and admin" do
    expect(build(:chat_room, name: "test")).to be_valid
  end

  it "is invalid without a latitude" do
    room = build(:chat_room, latitude: nil)
    room.valid?
    expect(room.errors[:latitude]).to include("can't be blank")
  end

  it "is invalid without a longitude" do
    room = build(:chat_room, longitude: nil)
    room.valid?
    expect(room.errors[:longitude]).to include("can't be blank")
  end

  it "is invalid without an admin_id" do
    room = build(:chat_room, admin_id: nil)
    room.valid?
    expect(room.errors[:admin_id]).to include("can't be blank")
  end

  it "returns a valid admin user" do
    user = create(:user)
    room = create(:chat_room, admin_id: user.id)
    expect(room.admin_id).to eq(user.id)
  end

  it "returns all the messages in the chatroom" do
    user = create(:user)
    room = create(:chat_room, admin_id: user.id)
    message = room.messages.create(content: "hello")
    expect(room.messages).to include(message)
  end
end