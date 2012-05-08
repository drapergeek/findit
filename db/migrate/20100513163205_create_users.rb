class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.timestamp :last_login
      t.timestamp :last_login_ip
      t.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end
