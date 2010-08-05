class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :make
      t.string :model
      t.string :processor
      t.integer :processor_rating
      t.integer :ram
      t.string :hard_drive
      t.string :serial
      t.string :vt_tag
      t.timestamp :purchased_at
      t.timestamp :warranty_expires_at
      t.timestamp :recieved_at
      t.string :os
      t.string :type
      t.timestamps
    end
  end
  
  def self.down
    drop_table :items
  end
end
