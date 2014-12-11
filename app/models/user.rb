class User < ActiveRecord::Base
  has_and_belongs_to_many :chat_rooms, -> { uniq }

  validates_presence_of :fb_name, :fb_id
  validates_uniqueness_of :fb_id

  def self.find_by_facebook_id(fb_id)
    User.find_or_create_by(fb_id:fb_id)
  end
end
