class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # Validations
  validates :cart_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
