class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
    add_index :order_products, [:order_id, :product_id]
  end
end
