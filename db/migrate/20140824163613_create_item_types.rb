class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
