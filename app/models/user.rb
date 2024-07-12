class User < ApplicationRecord
  has_one :cart
  has_many :orders
  has_one :tax, foreign_key: "province", primary_key: "province"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[id username name email address province_id created_at updated_at]
  end

  validates :province, presence: true
end
