# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
City.destroy_all
Gossip.destroy_all
PrivateMessage.destroy_all
Tag.destroy_all
User.destroy_all

10.times do
  City.create(name: Faker::Address.city,
              zip_code: Faker::Address.zip_code
  )
end

10.times do
  Tag.create(title: Faker::Lorem.sentence(word_count: 1))
end

10.times do
  PrivateMessage.create(content: Faker::Lorem.sentence(word_count: 10))
end

recipient_number = 1
City.all.each do |city|
  10.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              description: Faker::Lorem.sentences(2),
              email: Faker::Internet.safe_email,
              age: Faker::Number.between(18, 60),
              city_id: city.id)
  end

20.times do
    randomuser = User.all.where(city_id: city.id).sample
    Gossip.create(title: Faker::Lorem.sentence(word_count: 3),
                          content: Faker::Lorem.sentence(word_count: 10),
                          user_id: randomuser.id
    )
  end

 recipient_number = Faker::Number.between(1, 3)
  
  if recipient_number == 1
    privatemessage = PrivateMessage.create(content: Faker::GameOfThrones.quote, date: Faker::Date.forward(7), sender_id: User.all.sample.id, receiver_id: User.all.sample.id, receiver2_id: nil, receiver3_id: nil)
    
  elsif recipient_number == 2
    privatemessage = PrivateMessage.create(content: Faker::GameOfThrones.quote, date: Faker::Date.forward(7), sender_id: User.all.sample.id, receiver_id: User.all.sample.id, receiver2_id: User.all.sample.id, receiver3_id: nil)
    
  elsif recipient_number == 3
    privatemessage = PrivateMessage.create(content: Faker::GameOfThrones.quote, date: Faker::Date.forward(7), sender_id: User.all.sample.id, receiver_id: User.all.sample.id, receiver2_id: User.all.sample.id, receiver3_id: User.all.sample.id)
  end
end