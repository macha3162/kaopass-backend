# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


timings = ['10:00 AM - 10:40 AM', '10:45 AM - 11:10 AM', '11:15 AM - 11:55 AM', '12:40 PM - 1:05 PM',
           '1:10 PM - 1:35 PM', '1:40 PM - 2:20 PM', '2:25 PM - 2:50 PM', '2:55 PM - 3:20 PM', '3:05 PM - 4:05 PM', '3:30 PM - 3:55 PM']
places = %w(MainHall CommunityArea SubHall)

Session.destroy_all

timings.each.with_index(1) do |time, index|
  title = "session_#{index} this is title"
  detail = "session_#{index} this is session details."
  Session.create(number: index, time: time, place: places.sample, title: title, detail: detail)
end