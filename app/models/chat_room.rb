class ChatRoom < ActiveRecord::Base
  attr_accessor :address
  #include Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode

  has_and_belongs_to_many :users, -> { uniq }
  has_many :messages
  belongs_to :admin, :class_name => 'User'
end
