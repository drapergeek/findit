class ChangeItemToTypeToItemType < ActiveRecord::Migration
  def self.up
    rename_column :items, :type, :type_of_item
  end

  def self.down
    rename_column :items, :type_of_item, :type
  end
end
