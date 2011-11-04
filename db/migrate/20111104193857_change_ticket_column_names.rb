class ChangeTicketColumnNames < ActiveRecord::Migration
  def self.up
    rename_column :tickets, :project_id_id, :project_id
    rename_column :tickets, :area_id_id, :area_id
    rename_column :tickets, :submitter_id_id, :submitter_id
    rename_column :tickets, :worker_id_id, :worker_id
  end

  def self.down
  end
end
