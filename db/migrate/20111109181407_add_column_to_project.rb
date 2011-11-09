class AddColumnToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :keywords, :string
  end

  def self.down
  end
end
