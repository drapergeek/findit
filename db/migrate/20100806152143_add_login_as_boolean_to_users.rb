class AddLoginAsBooleanToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :can_login, :boolean
    User.reset_column_information
    User.all.each do |u|
      u.update_attribute :can_login, true
    end
  end

  def self.down
    remove_column :users, :can_login
  end
end
