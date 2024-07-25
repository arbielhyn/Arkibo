class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # Validations
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
