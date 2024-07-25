class Category < ApplicationRecord
  has_many :products

  # Validation
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 10 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
