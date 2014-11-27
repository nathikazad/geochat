json.extract! @chat_room, :id, :name, :latitude, :longitude, :created_at, :updated_at
json.users @chat_room.users do |user|
  json.nick_name user.nick_name
  json.id user.id
end