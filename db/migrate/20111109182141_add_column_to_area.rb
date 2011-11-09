class AddColumnToArea < ActiveRecord::Migration
  def self.up
    add_column :areas, :keywords, :string
  end

  def self.down
  end
end
