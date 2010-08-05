class AddBuildingToIp < ActiveRecord::Migration
  def self.up
    add_column :ips, :building_id, :integer
  end

  def self.down
    remove_column :ips, :building_id
  end
end
