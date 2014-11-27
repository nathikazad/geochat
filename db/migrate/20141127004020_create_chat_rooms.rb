class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.belongs_to :admin
      t.timestamps
    end
  end
end
