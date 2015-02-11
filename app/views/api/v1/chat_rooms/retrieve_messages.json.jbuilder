json.messages @messages.last(20) do |message|
  json.message_index message.index_number
  json.content message.content
  json.user_id    message.user.id
  json.user_name    message.user.nick_name
  json.time     message.created_at
end