class DropAnnouncements < ActiveRecord::Migration
  def self.up
    drop_table :announcements
  end

  def self.down
  end
end
