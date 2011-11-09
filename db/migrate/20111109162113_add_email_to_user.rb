class AddEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    User.reset_column_information
    User.all.each do |u|
      u.email = u.login + "@vt.edu"
      u.save
    end
  end

  def self.down
    remove_column :users, :email
  end
end
