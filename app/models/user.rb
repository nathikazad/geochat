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

end