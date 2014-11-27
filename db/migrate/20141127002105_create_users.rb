class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick_name
      t.string :fb_id, index: true
      t.string :fb_name

      t.timestamps
    end
  end
end
