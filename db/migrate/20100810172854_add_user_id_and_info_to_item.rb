class AddUserIdAndInfoToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :user_id, :integer
    add_column :items, :info, :text
  end

  def self.down
    remove_column :items, :user_id
    remove_column :items, :info
  end
end
