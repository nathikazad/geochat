class Notification
  def self.send_apns(device_tokens)
    notifications = device_tokens.map { |device_token| APNS::Notification.new(device_token, "You've got a new message!" ) }
    APNS.send_notifications(notifications)
  end 
  def self.broadcast(channel, block)
    message = {:channel => channel, :data => block, :ext => {:auth_token => "test"}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end