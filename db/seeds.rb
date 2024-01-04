# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.create(tourname: "Domestic touris")
# Category.create(tourname: "Travel abroad")

# 5.times do |i|
#     list_tour = ListTour.new(
#         name: "Du lich mien #{i+1}",
#         category_id: 1
#     )
#     if list_tour.save
#         puts "ListTour #{i + 1} created successfully"
#     else
#         puts "Error creating ListTour #{i + 1}: #{list_tour.errors.full_messages.join(', ')}"
#     end
# end
123.upto(130) do |i|
    title = "Tour #{Faker::Lorem.words(number: 3).join(' ')}"
    quantity = Faker::Number.between(from: 50, to: 100)
    price = 66*(Faker::Number.between(from: 1, to: 10).to_i)
    status = "trend"
    description = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true)
    list_tour_id = Faker::Number.between(from: 1, to: 5)
    
    tour = Tour.create(
      title: title,
      quantity: quantity,
      price: price,
      status: status,
      description: description,
      list_tour_id: list_tour_id,
      created_at: rand(2.years).seconds.ago
    )
    
    tour.image.attach(io: URI.open(Faker::LoremFlickr.image(size: "600x600")), filename: Faker::LoremFlickr.image(size: "600x600").split('/').last)
    
    if tour.save
      puts "Tour #{i} created successfully"
    else
      puts "Error creating Tour #{i}: #{tour.errors.full_messages.join(', ')}"
    end
end
# # Create 2000 sample data
# 20000.times do |i|
#     tour = Tour.new(
#       title: "Tour Hoi An #{i + 1}",
#       description: "Description for Tour #{i + 1}",
#       price: rand(10.0..100.0).round(2),
#       list_tour_id: 1
#     )
  
#     if tour.save
#       puts "Tour #{i + 1} created successfully"
#     else
#       puts "Error creating Tour #{i + 1}: #{tour.errors.full_messages.join(', ')}"
#     end
# end
