class AddOsToSoftwareAndItems < ActiveRecord::Migration
  def self.up
    add_column :items, :operating_system_id, :integer
    add_column :softwares, :operating_system_id, :integer
  end

  def self.down
    remove_column :items, :operating_system_id
    remove_column :softwares, :operating_system_id
  end
end
