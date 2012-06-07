class ChangeColumnForHardDrivesAndRamToBigInt < ActiveRecord::Migration
  def self.up
    change_column :items, :hard_drive, :string
    change_column :items, :ram, :string
  end

  def self.down
    change_column :items, :hard_drive, :string
    change_column :items, :ram, :string
  end
end
