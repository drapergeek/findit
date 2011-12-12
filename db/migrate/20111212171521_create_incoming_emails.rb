class CreateIncomingEmails < ActiveRecord::Migration
  def self.up
    create_table :incoming_emails do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :incoming_emails
  end
end
