class User < ActiveRecord::Base
  has_and_belongs_to_many :chat_rooms, -> { uniq }

  validates_presence_of :fb_name, :fb_id
  validates_uniqueness_of :fb_id
  before_create :generate_channel_name
  def self.find_by_facebook_id(fb_id)
    user = User.find_by(fb_id: fb_id)
    user.nil? ? User.create(fb_id: fb_id) : user
  end

  def generate_channel_name
    self.channel_name=Digest::SHA256.hexdigest(fb_id)[11..22]
  end

  def notify(json_data)
    send_apns(json_data) if device_token
    send_faye(json_data)
  end

  def send_apns(json_data)
    APNS.send_notifications([APNS::Notification.new(device_token, json_data)])
  end

  def send_faye(json_data)
    message = {:channel => channel_name, :data => json_data, :ext => {:auth_token => "test"}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end