class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :unit_price, presence: true

  # Ransack configuration
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "product_id", "quantity", "unit_price", "updated_at"]
  end
end
