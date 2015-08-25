class Order < ActiveRecord::Base
  attr_accessible :discount, :sub_total, :total_items, :user_id

  belongs_to :user

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :total_items, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sub_total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
