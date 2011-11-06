class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :priority
      t.date :start_date
      t.date :due_date
      t.references :submitter_id
      t.references :worker_id
      t.references :project_id
      t.references :area_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
