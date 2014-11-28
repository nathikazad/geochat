class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :user, index: true
      t.belongs_to :chat_room, index: true
      t.integer    :index_number, index:true
      t.timestamps
    end
  end
end
