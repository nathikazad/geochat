class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.float :latitude, index: true
      t.float :longitude, index: true
      t.belongs_to :admin, index: true
      t.timestamps
    end
  end
end
