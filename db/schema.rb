require 'bundler/setup'
Bundler.require(:default)
require 'csv'

DB = Sequel.postgres('sfx')

DB.create_table :students do
  primary_key :id
  String :first_name
  String :last_name
  String :class
  String :number
end

DB.create_table :activities do
  primary_key :id
  String :name
  Integer :limit
  String :day
end

DB.create_table :subscriptions do
  foreign_key :student_id, :students
  foreign_key :activity_id, :activities
  primary_key [:student_id, :activity_id]
end

DB.transaction do
  activities = DB[:activities]
  activities.insert(name: 'Badminton', limit: 15, day: 'tuesday')
  activities.insert(name: 'Fitness / tussen 2 vuren', limit: 15, day: 'tuesday')
  activities.insert(name: 'Basket', limit: 30, day: 'tuesday')
  activities.insert(name: 'Lezen / Gezelschapsspelletjes', limit: 15, day: 'tuesday')
  activities.insert(name: 'Film', limit: 40, day: 'tuesday')
  activities.insert(name: 'Typtop', limit: 15, day: 'tuesday')
  activities.insert(name: 'Lopen', limit: 15, day: 'tuesday')
  activities.insert(name: 'Volleybal', limit: 15, day: 'tuesday')
  activities.insert(name: 'Toneel', limit: 15, day: 'tuesday')
  activities.insert(name: 'Techniek', limit: 15, day: 'tuesday')
  activities.insert(name: 'Voetbal jongens', limit: 15, day: 'tuesday')
  activities.insert(name: 'Gezelschapsspelletjes', limit: 15, day: 'tuesday')

  activities.insert(name: 'Voetbal jongens', limit: 15, day: 'thursday')
  activities.insert(name: 'Badminton', limit: 15, day: 'thursday')
  activities.insert(name: 'Fitness / tussen 2 vuren', limit: 15, day: 'thursday')
  activities.insert(name: 'Knutselen / Decorbouw', limit: 15, day: 'thursday')
  activities.insert(name: 'Dans', limit: 30, day: 'thursday')
  activities.insert(name: 'Film', limit: 20, day: 'thursday')
  activities.insert(name: 'Kunst', limit: 15, day: 'thursday')
  activities.insert(name: 'Basket', limit: 15, day: 'thursday')
  activities.insert(name: 'Typtop', limit: 15, day: 'thursday')
  activities.insert(name: 'Techniek', limit: 15, day: 'thursday')
  activities.insert(name: 'Voetbal meisjes', limit: 15, day: 'thursday')
  activities.insert(name: 'Knutselen', limit: 10, day: 'thursday')
end

DB.transaction do
  students = DB[:students]
  CSV.foreach("#{__dir__}/students.csv") do |row|
    students.insert(class: row[0], number: row[1], last_name: row[2], first_name: row[3])
  end
end
