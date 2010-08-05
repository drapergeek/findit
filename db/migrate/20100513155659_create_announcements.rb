class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string :name
      t.text :info
      t.timestamp :start_at
      t.timestamp :end_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :announcements
  end
end
