# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include Tenantable

i = 1
for i in 1..10 do
  Seller.create(name: "Seller #{i}", type: "Seller", slug: "seller-#{i}", email: "seller-#{i}@test.com", password: "seller-1")
  Buyer.create(name: "Buyer #{i}", type: "Buyer", slug: "buyer-#{i}", email: "buyer-#{i}@test.com", password: "buyer-1")
end

all_seller = Seller.all

all_seller.each do |seller|
  10.times do
    write_to_seller_with_tenant do
      Product.create(name: "Product by #{seller.id}", slug: "product_by_seller_#{seller.id}", seller_id: seller.id)
    end
  end
end

read_seller_with_tenant do
  @product_details = Product.all.pluck(:id, :seller_id)
end

@product_details.each do |product_id, seller_id|
  10.times do
    write_to_seller_with_tenant do
      ProductDetail.create(product_id: @product_details.sample[0], quantity: 1000, price: 1000, type: 'Purchase')
    end
  end
end