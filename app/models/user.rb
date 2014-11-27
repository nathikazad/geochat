class User < ActiveRecord::Base
  has_and_belongs_to_many :chat_rooms, -> { uniq }
  def self.find_by_facebook_id(fb_id)
    User.find_or_create_by(fb_id:fb_id)
  end
end
