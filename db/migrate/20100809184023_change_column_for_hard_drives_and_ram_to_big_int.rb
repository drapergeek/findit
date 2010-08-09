class ChangeColumnForHardDrivesAndRamToBigInt < ActiveRecord::Migration
  def self.up
    change_column :items, :hard_drive, :bigint
    change_column :items, :ram, :bigint
  end

  def self.down
    change_column :items, :hard_drive, :integer
    change_column :items, :ram, :bigint
  end
end
