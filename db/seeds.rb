require_relative 'data_for_seed'

puts "Cleaning database..."

Reminder.destroy_all
Item.destroy_all
Collection.destroy_all
Share.destroy_all
NetworkUser.destroy_all
Network.destroy_all
User.destroy_all

puts "Creating users and collections..."

  user_first = User.create(email: "tv@dividi.fr", password: '123456', password_confirmation: '123456')

  collections_creation(user_first)

  velo = Item.create(name: "velo", verbe: "to_sell", collection: user_first.collections.where(name: "Garage")[0], price_cents: 10000)
  trotinett = Item.create(name: "trotinette", verbe: "to_borrow", collection: user_first.collections.where(name: "Garage")[0], price_cents: 5000)

  user_second = User.create(email: "sl@dividi.fr", password: '123456', password_confirmation: '123456')
  user_third = User.create(email: "jbb@dividi.fr", password: '123456', password_confirmation: '123456')
  user_fourth = User.create(email: "cr@dividi.fr", password: '123456', password_confirmation: '123456')

  collections_creation(user_second)
  collections_creation(user_third)
  collections_creation(user_fourth)

  art_guerre = Item.create(name: "L'art de la guerre - Sun Tzu", verbe: "to_borrow", collection: user_second.collections.where(name: "Bibliothèque")[0])

  Reminder.create(user: user_second, item: velo)
  Reminder.create(user: user_first, item: art_guerre)

puts "#{User.all.size} users, #{Collection.all.size} collections, #{Item.all.size} items, #{Reminder.all.size} reminders in database !"

puts "Creating networks and links..."

  networks_creation(user_first)
  networks_creation(user_second)
  networks_creation(user_third)
  networks_creation(user_fourth)

  # User 1 have all people as friends, and 1 friend in a special network
  link1 = NetworkUser.create(user: user_second, network: user_first.networks.where(name: "Tous")[0])
  link2 = NetworkUser.create(user: user_third, network: user_first.networks.where(name: "Tous")[0])
  link3 = NetworkUser.create(user: user_fourth, network: user_first.networks.where(name: "Tous")[0])

  link4 = NetworkUser.create(user: user_second, network: user_first.networks.where(name: "Amis")[0])




puts "#{Share.all.size} table shared, #{Network.all.size} networks declared, #{NetworkUser.all.size} links network-user in database !"
