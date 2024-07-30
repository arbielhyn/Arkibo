class Tax < ApplicationRecord
  belongs_to :user, foreign_key: "province", primary_key: "province"

  # Validations for Tax model
  validates :province, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "id_value", "province", "pst", "updated_at"]
  end
end
