class CreateInstallations < ActiveRecord::Migration
  def self.up
    create_table :installations do |t|
      t.integer :software_id
      t.integer :item_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :installations
  end
end
