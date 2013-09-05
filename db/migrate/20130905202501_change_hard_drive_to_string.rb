class ChangeHardDriveToString < ActiveRecord::Migration
  def change
    change_column :items, :hard_drive, :string
    change_column :items, :ram, :string
  end
end
