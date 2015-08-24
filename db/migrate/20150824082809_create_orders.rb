class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :total_items, null: false
      t.decimal :sub_total, precision: 8, scale: 2, null: false
      t.decimal :discount, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
