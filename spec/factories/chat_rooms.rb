FactoryGirl.define do 
  factory :chat_room do
    admin_id { create(:user).id }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    name { Faker::App.name }
  end
end