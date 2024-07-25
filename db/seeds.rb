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
