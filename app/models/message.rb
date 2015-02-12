class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  validates_presence_of :content, :user_id, :chat_room_id

  before_create :add_index
  after_create :notify



private
  def add_index
    if chat_room.messages.count == 0
      self.index_number=1
    else
      self.index_number=chat_room.messages.last.index_number+1
    end
  end

  def notify
    #bulk notify APNS if its faster
    chat_room.users.map do |user|
      user.notify jsonify_for_notification
    end
  end

  def jsonify_for_notification
    json_data=self.attributes
    json_data["user_name"]=user.nick_name
    json_data["chat_room"]=chat_room.name
    json_data.slice("content","index_number","user_name","chat_room").to_json
  end
end
