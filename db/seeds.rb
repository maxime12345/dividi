require_relative 'data_for_seed'

puts "Cleaning database..."

Reminder.destroy_all
Share.destroy_all
Item.destroy_all
Category.destroy_all
Collection.destroy_all
NetworkUser.destroy_all
Network.destroy_all
User.destroy_all

puts "Creating categories"

categories = [
"Do-it-yourself",
"High-tech",
"Home appliance",
"Computers",
"Musical instruments",
"Gardening",
"Board games",
"Video games",
"Toys",
"Books",
"Cooking",
"Sport material",
"Furniture",
"Vehicles",
"Bicycles",
"Clothing",
"Others",
"Camping"]

verbes = [ "To Sell", "To Give", "To Lend", "To Rent"]

categories.each do |category|
  Category.create(name: category)
end

puts "#{Category.count} categories created"

puts "Creating users and collections..."

  user_first = User.create( username: "Thibault",
                            email: "tv@dividi.fr",
                            password: '123456',
                            password_confirmation: '123456',
                            avatar: File.open("#{Rails.root}/app/assets/images/images_seed/thibault.jpg"))
  collections_creation(user_first)

  velo = Item.create( name: "Vélo",
                      description: "Une affaire : une seule vitesse pour éviter de payer la salle de gym. Klaxon intégré dans le frein arrière pour éviter les dangers !",
                      verbe: "To Sell",
                      collection: user_first.collections.where(name: "All")[0],
                      price_cents: 1000,
                      remote_photo_url: "https://forum.tontonvelo.com/download/file.php?id=38382",
                      category: Category.where(name: "Bicycles")[0])

  trottinette = Item.create(  name: "Trotinette",
                              verbe: "To Lend",
                              collection: user_first.collections.where(name: "All")[0],
                              category: Category.where(name: "Vehicles")[0])


  test_portrait_image = Item.create(  name: "Bureau en bois",
                                      verbe: "To Give",
                                      collection: user_first.collections.where(name: "All")[0],
                                      remote_photo_url: "http://doublemoda.com/wp-content/uploads/2018/06/32-superbe-plan-le-bon-coin-bureau-le-bon-coin-meuble-bureau-hotelfrance-avec-bon-coin-of-le-bon-coin-bureau.jpg",
                                      category: Category.where(name: "Home appliance")[0])

  test_little_image = Item.create(  name: "Petite boite metal",
                                    description: "test little image",
                                    verbe: "To Give",
                                    collection: user_first.collections.where(name: "All")[0],
                                    remote_photo_url: "https://www.chezfee.com/images/stories/virtuemart/product/petit-boite-metal-coeur-lion1-chezfee1.jpg",
                                    category: Category.where(name: "Others")[0])

  user_second = User.create(  username: "Sarah",
                              email: "sl@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/sarah.png"))

  user_third = User.create(   username: "JB",
                              email: "jbb@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jb.jpeg"))

  user_fourth = User.create(  username: "Christine",
                              email: "cr@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/christine.png"))

  user5 = User.create(        username: "Patoche",
                              email: "sebastien.patoche@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/patoche.jpg"))

  user6 = User.create(        email: "paul.dupont@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456')

  user7 = User.create(        email: "jpheos@dividi.fr", password: '123456', password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jpheos.jpeg"))

  user8 = User.create(        username: "Titouan",
                              email: "tm@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/titouan.jpeg"))

  User.all.select{ |user| user != user_first }.each{ |user| collections_creation(user) }

  test_landscape_image = Item.create( name: "Tente familiale",
                                      description: "5 places avec un hauvent",
                                      verbe: "To Rent",
                                      collection: user_second.collections.where(name: "All")[0],
                                      price_cents: 900,
                                      remote_photo_url: "https://www.voyagesetenfants.com/wp-content/uploads/2017/05/P1130541-cmp.jpg",
                                      category: Category.where(name: "Camping")[0])

  art_guerre = Item.create( name: "L'art de la guerre - Sun Tzu",
                            verbe: "To Lend",
                            collection: user_second.collections.where(name: "All")[0],
                            category: Category.where(name: "Books")[0])

  appareil_raclette = Item.create(name: "Appareil à raclette 8 personnes",
                                  verbe: "To Lend",
                                  collection: user_second.collections.where(name: "All")[0],
                                  category: Category.where(name: "Cooking")[0])

  miroir = Item.create(           name: "Miroir",
                                  verbe: "To Sell",
                                  price_cents: 2000,
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/miroir.jpg"),
                                  category: Category.where(name: "Furniture")[0])

  lampes = Item.create(          name: "Lampes et Lustres",
                                  verbe: "To Give",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/lampes.jpg"),
                                  category: Category.where(name: "Furniture")[0])

  iphone = Item.create(          name: "Iphone",
                                  verbe: "To Sell",
                                  price_cents: 22000,
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/iphone.jpg"),
                                  category: Category.where(name: "High-tech")[0])

  msi = Item.create(          name: "Ordi MSI",
                                  verbe: "To Sell",
                                  price_cents: 60000,
                                  collection: user7.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/msi.jpg"),
                                  category: Category.where(name: "High-tech")[0])


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



User.all.each{ |user| share_creation(user) }

puts "#{Share.all.size} table shared, #{Network.all.size} networks declared, #{NetworkUser.all.size} links network-user in database !"



