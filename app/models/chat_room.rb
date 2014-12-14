class ChatRoom < ActiveRecord::Base
  attr_accessor :address, :distance
  #include Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode

  validates_presence_of :latitude, :longitude, :admin_id

  has_and_belongs_to_many :users, -> { uniq }
  has_many :messages
  belongs_to :admin, :class_name => 'User'

  def messages_since(index)
    self.messages.where("index_number>?",index)
  end
end