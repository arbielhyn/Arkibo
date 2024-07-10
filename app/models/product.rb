class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images

  scope :on_sale, -> { where(on_sale: true) }

  validates :name, :description, :price, :size, :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  paginates_per 8

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "size", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
