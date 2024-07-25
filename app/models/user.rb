class User < ApplicationRecord
  has_one :cart
  has_many :orders
  has_one :tax, foreign_key: "province", primary_key: "province"

  # Validations
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :street, :city, :postal_code, :province, presence: true
  validates :postal_code,
            format: { with:    /\A[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d\z/,
                      message: "must be in the format A1A 1A1" }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[id username name email address province_id created_at updated_at]
  end
end
