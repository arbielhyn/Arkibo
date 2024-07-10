class User < ApplicationRecord
  has_one :cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Define ransackable attributes for searching
  def self.ransackable_attributes(auth_object = nil)
    %w[id username name email address province_id created_at updated_at]
  end
end
