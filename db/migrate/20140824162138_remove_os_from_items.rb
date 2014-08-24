class RemoveOsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :os, :string
  end
end
