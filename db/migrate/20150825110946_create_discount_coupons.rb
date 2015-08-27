class CreateDiscountCoupons < ActiveRecord::Migration
  def change
    create_table :discount_coupons do |t|
      t.string :coupon, null: false
      t.boolean :is_active, null: false

      t.timestamps
    end
  end
end
