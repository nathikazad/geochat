require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with nickname, fb_id, and fb_name"
  it "is invalid without a fb_name"
  it "is invalid without a fb_id"
  it "is invalid with a duplicate facebook id"
  it "returns a new contact if you search by non-existent facebook id"
  it "returns a pre-existing contact when you search by existent facebook id"
end