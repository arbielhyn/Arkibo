class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :order_date, :total_amount, :status, presence: true
end
