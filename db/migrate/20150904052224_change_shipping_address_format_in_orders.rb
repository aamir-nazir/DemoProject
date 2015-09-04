class ChangeShippingAddressFormatInOrders < ActiveRecord::Migration
  def up
    change_column :orders, :shipping_address, :text
  end

  def down
    change_column :orders, :shipping_address, :string
  end
end
