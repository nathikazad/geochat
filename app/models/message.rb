class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room
  before_save :add_index

  after_create :notify_chat_room

  def add_index
    if self.chat_room.messages.count!=0
      self.index_number=self.chat_room.messages.last(2)[0].index_number+1
    else
      self.index_number=0
    end
  end

  def notify_chat_room
    ChatRoom.send_notifications(self.chat_room_id)
  end
end
