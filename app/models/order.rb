class Order < ActiveRecord::Base
  attr_accessible :discount, :sub_total, :total_items, :user_id, :shipping_address

  belongs_to :user

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :total_items, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sub_total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :find_orders, ->(user_id) { where(user_id: user_id) }

  def process_payment(sub_total, credit_card_no, card_expiry, user, address)
    transaction = AuthorizeNet::AIM::Transaction.new(API_LOGIN_ID, API_TRANSACTION_ID, gateway: :sandbox)
    credit_card = AuthorizeNet::CreditCard.new(credit_card_no, card_expiry)

    customer = AuthorizeNet::Customer.new(email: user.email)
    shipping_address = AuthorizeNet::ShippingAddress.new(street_address: address)
    customer_address = AuthorizeNet::Address.new(first_name: user.first_name, last_name: user.last_name)

    transaction.set_customer(customer)
    transaction.set_shipping_address(shipping_address)
    transaction.set_address(customer_address)

    transaction.purchase(sub_total, credit_card)
  end
end
