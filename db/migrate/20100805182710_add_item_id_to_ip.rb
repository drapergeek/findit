class AddItemIdToIp < ActiveRecord::Migration
  def self.up
    add_column :ips, :item_id, :integer
  end

  def self.down
    remove_column :ips, :item_id
  end
end
