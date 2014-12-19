class ChatRoom < ActiveRecord::Base
  attr_accessor :address, :distance
  #include Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode

  validates_presence_of :latitude, :longitude, :admin_id

  has_and_belongs_to_many :users, -> { uniq }
  has_many :messages
  belongs_to :admin, :class_name => 'User'

  after_create :add_admin_to_chat_room

  def messages_since(index)
    self.messages.where("index_number>?",index)
  end

  def add_admin_to_chat_room
    self.users << self.admin
  end

  def device_tokens
    # what if the user doesn't allow push notifications? still need to account
    self.users.pluck(:device_token)
  end

  def self.send_notifications(room_id)
    Notification.send_apns(ChatRoom.find_by(id: room_id).device_tokens)
  end
end