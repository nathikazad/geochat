FactoryGirl.define do
    factory :user do
      fb_id { Faker::Internet.password(64) }
      fb_name { Faker::Name.name }
      nick_name { Faker::Name.name }
      device_token { Faker::Internet.password(64) }
    end
    
    factory :invalid_user, class: User do
    end
end