class RemoveIncomingEmailsTable < ActiveRecord::Migration
  def up
    drop_table :incoming_emails

  end

  def down
    create_table :incoming_emails do |t|
      t.timestamps
    end
  end
end
