FactoryGirl.define do
  factory :message do
    content { Faker::Lorem.sentence }
    user { create(:user) }
    chat_room { create(:chat_room) }
  end
end