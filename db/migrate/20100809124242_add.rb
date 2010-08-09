class Add < ActiveRecord::Migration
  def self.up
    add_column :dns_names, :item_id, :integer
  end

  def self.down
    remove_column :dns_names, :item_id
  end
end
