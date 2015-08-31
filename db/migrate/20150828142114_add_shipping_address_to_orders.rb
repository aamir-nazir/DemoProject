class AddShippingAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_address, :string, null: false
  end
end
