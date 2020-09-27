# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Doctor.destroy_all
puts "DESTROYED : User"

User.destroy_all
puts "DESTROYED : User"




User.create!(firstname: "max", lastname: "Dupond2",
  email: "max.dupond2@gmail.com", phone: "0610001000", password: "123132")
User.create!(firstname: "antoine", lastname: "jibo",
  email: "antoine.jibo@gmail.com", phone: "0610001001", password: "123132")

User.create!(firstname: "jean", lastname: "eude",
  email: "jean.eude@gmail.com", phone: "0655566688", password: "123132",
  is_doctor: true)

puts "Users created"
