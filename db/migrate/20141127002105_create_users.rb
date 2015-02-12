class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick_name
      t.string :fb_id, index: true
      t.string :fb_name
      t.string :device_token
      t.string :channel_name

      t.timestamps
    end
  end
end
