class AddlastInventoriedAtToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :inventoried_at, :datetime

  end

  def self.down
    remove_column :items, :inventoried_at
  end
end
