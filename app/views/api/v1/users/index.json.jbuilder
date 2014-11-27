json.array!(@users) do |user|
  json.extract! user, :id, :nick_name, :fb_id, :fb_name
  json.url user_url(user, format: :json)
end
