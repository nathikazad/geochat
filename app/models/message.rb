class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room
  before_save :add_index

  def add_index
    if self.chat_room.messages.count!=0
      self.index_number=self.chat_room.messages.last(2)[0].index_number+1
    else
      self.index_number=0
    end
  end
end
