class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :total_amount, :status, presence: true

  def subtotal_amount
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def subtotal
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def pst_amount
    tax_rates = Tax.find_by(province: user.province) || OpenStruct.new(pst: 0)
    subtotal * ((tax_rates.pst || 0) / 100.0)
  end

  def gst_amount
    tax_rates = Tax.find_by(province: user.province) || OpenStruct.new(gst: 0)
    subtotal * ((tax_rates.gst || 0) / 100.0)
  end

  def hst_amount
    tax_rates = Tax.find_by(province: user.province) || OpenStruct.new(hst: 0)
    subtotal * ((tax_rates.hst || 0) / 100.0)
  end

  def tax_amount
    (pst_amount + gst_amount + hst_amount).round(2)
  end

  def total_amount
    (subtotal + tax_amount).round(2)
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
