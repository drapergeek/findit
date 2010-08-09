class CreateDnsNames < ActiveRecord::Migration
  def self.up
    create_table :dns_names do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :dns_names
  end
end
