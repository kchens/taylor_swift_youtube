require 'Faker'

5.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "password")
end

10.times do
  Product.create(name: Faker::Commerce.product_name, designer: Faker::Company.name, price: Faker::Address.building_number, category: Faker::Commerce.department)
end