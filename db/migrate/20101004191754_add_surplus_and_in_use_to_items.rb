class AddSurplusAndInUseToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :in_use, :boolean
    add_column :items, :surplused_at, :timestamp
    Item.reset_column_information
    Item.all.each do |i|
      i.update_attribute :in_use, true
    end
  end

  def self.down
    remove_column :items, :in_use
    remove_column :items, :surplused_at
  end
end
