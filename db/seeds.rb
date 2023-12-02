# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
2.times do |index|
    Post.create! title: "Draft post", discription:"On the 2nd and 3rd day, we went out to other famous places in Danang such as Ba Na Hills, Marble Mountains, Helio Market",status: "draft"
    Post.create! title: "Published article",discription:"On the 4nd and 3rd day, we went out to other famous places in Phu Yen such as Mui Dien, Phu Yen Beach", status: "published"
end
