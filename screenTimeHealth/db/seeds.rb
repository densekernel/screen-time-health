# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_price(from, to)
  rand_in_range(from, to).round(2)
end

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

family_list = [
  ["Addams", "test@test.com", "$2a$10$vVwcMGiTisbzM1LzQaqfPu6a/eGgrSYTrlNa7dfqIjbrNd6wMGqNe", "$2a$10$vVwcMGiTisbzM1LzQaqfPu6a/eGgrSYTrlNa7dfqIjbrNd6wMGqNe"]
]

family_list.each do |family|
  Family.create(:surname => family[0], :email => family[1], :password => family[2], :encrypted_password => family[3])
end



kid_list = [
  [ "Gomez" ],
  [ "Pugsley" ],
  [ "Grandma Frump" ],
  [ "Wednesday" ]
]

kid_list.each do |kid|
  Kid.create( :name => kid[0], :family_id => 1)
end

(1..100).each do |n|
  startIndex = (n * 24) + 8
  endIndex = (n * 24) + 7
  endEndIndex = (n * 24) + 2
  startTime = rand_time(startIndex.hours.ago, endIndex.hours.ago)
  endTime = rand_time(endIndex.hours.ago, endEndIndex.hours.ago)
  familyMember = rand_int(1, 5)
  Session.create(:startTime => startTime, :endTime => endTime, :kid_id => familyMember)
end