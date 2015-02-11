class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  validates_presence_of :content, :user_id, :chat_room_id

  before_create :add_index
  after_create :notify

  def add_index
    if chat_room.messages.count == 0
      self.index_number=1
    else
      self.index_number=chat_room.messages.last.index_number+1
    end
  end



  def notify
    #Notification.send_apns(self.device_tokens_of_disconnected)
    chat_room.connected_users.map do |user|
      #channel_name = "/" + Digest::SHA256.hexdigest("#{user.id}")
      channel_name = "/server"
      broadcast channel_name, jsonify_for_notification
    end
  end

  def send_apns(device_tokens, json_data)
    notifications = device_tokens.map { |device_token| APNS::Notification.new(device_token, json_data ) }
    APNS.send_notifications(notifications)
  end

  def broadcast(channel, json_data)
    message = {:channel => channel, :data => json_data, :ext => {:auth_token => "test"}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def jsonify_for_notification
    json_data=self.attributes
    json_data["user_name"]=user.nick_name
    json_data["chat_room"]=chat_room.name
    json_data.slice("content","index_number","user_name","chat_room").to_json
  end
end
