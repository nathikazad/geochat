require 'rails_helper'

describe Message, :type => :model do
  it "has a valid factory" do
    expect(build(:message)).to be_valid
  end

  it "is valid with content, user, and chat room" do
    expect(build(:message, content: "This is a test message")).to be_valid
  end 

  context "validates presence" do
    it "is invalid without content" do
      expect(build(:message, content: "")).to be_invalid
    end

    it "is invalid without a user_id" do
      expect(build(:message, user_id: nil)).to be_invalid
    end
    
    it "is invalid without a chat_room_id" do
      expect(build(:message, chat_room_id: nil)).to be_invalid
    end
  end  
end 