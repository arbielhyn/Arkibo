# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
require "faker"

# Clear existing data
Category.destroy_all
Product.destroy_all

# Define available sizes
sizes = %w[XS S M L XL XXL]

# Create categories
categories = []
4.times do
  categories << Category.create!(name: Faker::Commerce.department(max: 1))
end

# Create products
100.times do
  Product.create!(
    name:        Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price:       Faker::Commerce.price(range: 10..100.0),
    category:    categories.sample,
    size:        sizes.sample
  )
end

puts "Seeded #{Category.count} categories and #{Product.count} products."
