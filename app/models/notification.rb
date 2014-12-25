class Notification
  def self.send_apns(device_tokens)
    notifications = device_tokens.map { |device_token| APNS::Notification.new(device_token, "You've got a new message!" ) }
    APNS.send_notifications(notifications)
  end 
end