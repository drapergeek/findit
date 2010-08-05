class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string :name
      t.string :license_key
      t.string :os
      t.integer :number_of_licenses
      t.string :storage_location
      t.text :info
      t.timestamps
    end
  end
  
  def self.down
    drop_table :softwares
  end
end
