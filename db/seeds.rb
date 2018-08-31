require_relative 'data_for_seed'

puts "Cleaning database..."

Reminder.destroy_all
Item.destroy_all
Collection.destroy_all
Category.destroy_all
Share.destroy_all
NetworkUser.destroy_all
Network.destroy_all
User.destroy_all

puts "Creating categories"

categories = [
"Ameublement",
"Bricolage",
"DVD",
"Electroménager",
"Informatique",
"Instruments de musique",
"Jardinage",
"Jeux de sociétés",
"Jeux vidéos",
"Jouets",
"Livres",
"Matériel de Sport",
"Meubles",
"Véhicules",
"Vélos",
"Vêtements"]

categories.each do |category|
  Category.create(name: category)
end

puts "#{Category.count} categories created"

puts "Creating users and collections..."

  user_first = User.create(username: "Thibault", email: "tv@dividi.fr", password: '123456', password_confirmation: '123456',avatar: File.open("#{Rails.root}/app/assets/images/images_seed/thibault.jpg"))
  collections_creation(user_first)

  velo = Item.create(name: "velo", description: "Une affaire : une seule vitesse pour éviter de payer la salle de gym. Klaxon intégré dans le frein arrière pour éviter les dangers !",verbe: "to_sell", collection: user_first.collections.where(name: "Garage")[0], price_cents: 10000, remote_photo_url: "https://forum.tontonvelo.com/download/file.php?id=38382", category_id: 10)
  trottinette = Item.create(name: "trotinette", verbe: "to_borrow", collection: user_first.collections.where(name: "Garage")[0], price_cents: 5000, category_id: 11)
  test_landscape_image = Item.create(name: "tente familiale", description: "landscape_image_test", verbe: "to_sell", collection: user_first.collections.where(name: "Autres")[0], price_cents: 10000, remote_photo_url: "https://www.voyagesetenfants.com/wp-content/uploads/2017/05/P1130541-cmp.jpg")
  test_portrait_image = Item.create(name: "bureau en bois", description: "portrait image test ce bureau en bois est vraiment le plus beau de tous les objets en bois", verbe: "to_sell", collection: user_first.collections.where(name: "Autres")[0], price_cents: 10000, remote_photo_url: "http://doublemoda.com/wp-content/uploads/2018/06/32-superbe-plan-le-bon-coin-bureau-le-bon-coin-meuble-bureau-hotelfrance-avec-bon-coin-of-le-bon-coin-bureau.jpg")
  test_little_image = Item.create(name: "petite boite metal", description: "test little image", verbe: "to_sell", collection: user_first.collections.where(name: "Autres")[0], price_cents: 10000, remote_photo_url: "https://www.chezfee.com/images/stories/virtuemart/product/petit-boite-metal-coeur-lion1-chezfee1.jpg")



  user_second = User.create(username: "Sarah", email: "sl@dividi.fr", password: '123456', password_confirmation: '123456', avatar: File.open("#{Rails.root}/app/assets/images/images_seed/sarah.png"))
  user_third = User.create(username: "JB", email: "jbb@dividi.fr", password: '123456', password_confirmation: '123456', avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jb.jpeg"))

  user_fourth = User.create(email: "cr@dividi.fr", password: '123456', password_confirmation: '123456', avatar: File.open("#{Rails.root}/app/assets/images/images_seed/christine.png"))
  user5 = User.create(email: "sebastien.patoche@dividi.fr", password: '123456', password_confirmation: '123456', avatar: File.open("#{Rails.root}/app/assets/images/images_seed/patoche.jpg"))
  user6 = User.create(email: "paul.dupont@dividi.fr", password: '123456', password_confirmation: '123456')
  user7 = User.create(email: "chuck.norris@dividi.fr", password: '123456', password_confirmation: '123456')

  User.all[1..-1].each{ |user| collections_creation(user) }

  art_guerre = Item.create(name: "L'art de la guerre - Sun Tzu", verbe: "to_borrow", collection: user_second.collections.where(name: "Bibliothèque")[0], category_id: 11)

  Reminder.create(user: user_second, item: velo)
  Reminder.create(user: user_first, item: art_guerre)

puts "#{User.all.size} users, #{Collection.all.size} collections, #{Item.all.size} items, #{Reminder.all.size} reminders in database !"

puts "Creating networks and links..."

  User.all.each{ |user| networks_creation(user) }

  # User 1 have all people as friends, and 1 friend in a special network
  link1 = NetworkUser.create(user: user_second, network: user_first.networks.where(name: "Tous")[0])
  link1reverse = NetworkUser.create(user: user_first, network: user_second.networks.where(name: "Tous")[0])

  link2 = NetworkUser.create(user: user_third, network: user_first.networks.where(name: "Tous")[0])
  link2reverse = NetworkUser.create(user: user_first, network: user_third.networks.where(name: "Tous")[0])

  link3 = NetworkUser.create(user: user_fourth, network: user_first.networks.where(name: "Tous")[0])
  link3reverse = NetworkUser.create(user: user_first, network: user_fourth.networks.where(name: "Tous")[0])

  link4 = NetworkUser.create(user: user7, network: user_first.networks.where(name: "Tous")[0])
  link4reverse = NetworkUser.create(user: user_first, network: user7.networks.where(name: "Tous")[0])

  link5 = NetworkUser.create(user: user_second, network: user_first.networks.where(name: "Amis")[0])




puts "#{Share.all.size} table shared, #{Network.all.size} networks declared, #{NetworkUser.all.size} links network-user in database !"
