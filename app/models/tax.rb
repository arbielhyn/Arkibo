class Tax < ApplicationRecord
  belongs_to :user, foreign_key: "province", primary_key: "province"

  # Validations for Tax model
  validates :province, presence: true, uniqueness: true
end
