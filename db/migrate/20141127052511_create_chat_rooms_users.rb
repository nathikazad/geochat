class CreateChatRoomsUsers < ActiveRecord::Migration
  def change
    create_table :chat_rooms_users , id: false do |t|
      t.integer :chat_room_id, index: true
      t.integer :user_id, index: true
    end
  end
end
