require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with nickname, fb_id, and fb_name" do
    expect(build(:user, nick_name: "imuzz")).to be_valid
  end

  it "is invalid without a fb_name" do
    user = build(:user, fb_name: nil)
    user.valid?
    expect(user.errors[:fb_name]).to include("can't be blank") 
  end

  it "is invalid without a fb_id" do
    user = build(:user, fb_id: nil)
    user.valid?
    expect(user.errors[:fb_id]).to include("can't be blank")
  end

  it "is invalid with a duplicate facebook id" do
    art = create(:user)
    nathik = build(:user, fb_id: art.fb_id)
    nathik.valid?
    expect(nathik.errors[:fb_id]).to include("has already been taken")
  end
  
  it "returns a new contact if you search by non-existent facebook id"
  it "returns a pre-existing contact when you search by existent facebook id"
end