class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  scope :on_sale, -> { where(on_sale: true) }

  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  paginates_per 8

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "size", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
