class SetInUseToTrue < ActiveRecord::Migration
  def change
    change_column :items, :in_use, :boolean, default: true, null: false
  end
end
