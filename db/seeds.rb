require_relative 'data_for_seed'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning database..."

Reminder.destroy_all
Item.destroy_all
Collection.destroy_all
User.destroy_all

puts "Creating users and collections..."

user_first = User.create(email: "tv@dividi.fr", password: '123456', password_confirmation: '123456')

collections_creation(user_first)

velo = Item.create(name: "velo", verbe: "to_sell", collection: user_first.collections.where(name: "Garage")[0])
trotinette = Item.create(name: "trotinette", verbe: "to_borrow", collection: user_first.collections.where(name: "Garage")[0])

user_second = User.create(email: "sl@dividi.fr", password: '123456', password_confirmation: '123456')

Reminder.create(user: user_second, item: velo)

puts "#{User.all.size} users, #{Collection.all.size} collections, #{Item.all.size} items, #{Reminder.all.size} reminders in database !"
