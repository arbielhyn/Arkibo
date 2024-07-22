class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :total_amount, :status, presence: true

  def subtotal_amount
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def tax_amount
    tax_rates = Tax.find_by(province: user.province)
    subtotal = subtotal_amount

    return 0 if tax_rates.blank?

    tax_amount = 0
    tax_amount += subtotal * (tax_rates.pst / 100) if tax_rates.pst.present?
    tax_amount += subtotal * (tax_rates.gst / 100) if tax_rates.gst.present?
    tax_amount += subtotal * (tax_rates.hst / 100) if tax_rates.hst.present?

    tax_amount.round(2)
  end

  def total_amount
    subtotal_amount + tax_amount
  end
  # Ransack configuration
  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user"]
  end

  # Optional: Define searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_date", "status", "total_amount", "updated_at", "user_id"]
  end
end
