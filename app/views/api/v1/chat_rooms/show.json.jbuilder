json.extract! @chat_room, :id, :name, :latitude, :longitude, :created_at, :updated_at
json.users @chat_room.users do |user|
  json.nick_name user.nick_name
  json.id user.id
end
json.messages @chat_room.messages.last(20) do |message|
  json.message_index message.index_number
  json.content message.content
  json.user_id    message.user.id
  json.user_name    message.user.nick_name
  json.time     message.created_at
end