class AddDeltaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :delta, :boolean, default: true, null: false
  end
end
