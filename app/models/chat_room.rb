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

  def device_tokens_of_disconnected
    self.users.where(connected: false).pluck(:device_token)
  end

  def device_tokens_of_connected
    self.users.where(connected: true).pluck(:device_token)
  end

  def connected_users
    self.users.where(connected: true)
  end

end