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

# Create or find tax records
taxes = [
  { province: "Alberta", pst: 0, gst: 5.0, hst: 0 },
  { province: "British Columbia", pst: 7.0, gst: 5.0, hst: 0 },
  { province: "Manitoba", pst: 7.0, gst: 5.0, hst: 0 },
  { province: "New Brunswick", pst: 10.0, gst: 5.0, hst: 0 },
  { province: "Newfoundland and Labrador", pst: 10.0, gst: 5.0, hst: 0 },
  { province: "Northwest Territories", pst: 5.0, gst: 5.0, hst: 0 },
  { province: "Nova Scotia", pst: 10.0, gst: 5.0, hst: 0 },
  { province: "Nunavut", pst: 5.0, gst: 5.0, hst: 0 },
  { province: "Ontario", pst: 0, gst: 0, hst: 13.0 },
  { province: "Prince Edward Island", pst: 10.0, gst: 5.0, hst: 0 },
  { province: "Quebec", pst: 9.975, gst: 5.0, hst: 0 },
  { province: "Saskatchewan", pst: 6.0, gst: 5.0, hst: 0 },
  { province: "Yukon", pst: 0, gst: 5.0, hst: 0 }
]

taxes.each do |tax|
  Tax.find_or_create_by(province: tax[:province]) do |t|
    t.pst = tax[:pst]
    t.gst = tax[:gst]
    t.hst = tax[:hst]
  end
end

puts "Seeded #{Tax.count} tax records."
