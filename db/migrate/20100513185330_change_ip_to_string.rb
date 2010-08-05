class ChangeIpToString < ActiveRecord::Migration
  def self.up
    change_column :users, :last_login_ip, :string
  end

  def self.down
    change_column :users, :last_login_ip, :timestamp
  end
end
