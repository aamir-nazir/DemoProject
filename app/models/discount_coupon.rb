class DiscountCoupon < ActiveRecord::Base
  attr_accessible :coupon, :is_active

  DISCOUNT = 10

  scope :active, ->(coupon){ where(is_active: 1, coupon: coupon) }
end
