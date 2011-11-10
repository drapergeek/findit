class AddColumnToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :reply, :boolean
  end

  def self.down
    remove_column :comments, :reply
  end
end
