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
"Bricolage/Jardinage",
"Camping",
"CD/DVD",
"Cuisine",
"Equipement automobile",
"Jeux",
"Livres",
"Meubles",
"Multimédia",
"Matériel de sport",
"Véhicules",
"Vêtements",
"Autres"]



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

  tournevis = Item.create( name: "Tournevis de précision",
                      verbe: "To Lend",
                      collection: user_first.collections.where(name: "All")[0],
                      photo: File.open("#{Rails.root}/app/assets/images/images_seed/tournevis.jpg"),
                      category: Category.where(name: "Bricolage/Jardinage")[0])

  velo = Item.create( name: "Vélo",
                      description: "Une affaire : une seule vitesse pour éviter de payer la salle de gym. Klaxon intégré dans le frein arrière pour éviter les dangers !",
                      verbe: "To Sell",
                      collection: user_first.collections.where(name: "All")[0],
                      price_cents: 1000,
                      remote_photo_url: "https://forum.tontonvelo.com/download/file.php?id=38382",
                      category: Category.where(name: "Véhicules")[0])

  trottinette = Item.create(  name: "Trottinette",
                              verbe: "To Sell",
                              price_cents: 6000,
                              collection: user_first.collections.where(name: "All")[0],
                              photo: File.open("#{Rails.root}/app/assets/images/images_seed/trottinette.jpeg"),
                              category: Category.where(name: "Véhicules")[0])

   wonders = Item.create( name: "7 wonders",
                              verbe: "To Lend",
                              collection: user_first.collections.where(name: "All")[0],
                              photo: File.open("#{Rails.root}/app/assets/images/images_seed/7wonders.jpg"),
                              category: Category.where(name: "Jeux")[0])


  test_portrait_image = Item.create(  name: "Bureau en bois",
                                      verbe: "To Give",
                                      collection: user_first.collections.where(name: "All")[0],
                                      remote_photo_url: "http://doublemoda.com/wp-content/uploads/2018/06/32-superbe-plan-le-bon-coin-bureau-le-bon-coin-meuble-bureau-hotelfrance-avec-bon-coin-of-le-bon-coin-bureau.jpg",
                                      category: Category.where(name: "Meubles")[0])

  test_little_image = Item.create(  name: "Petite boite metal",
                                    description: "test little image",
                                    verbe: "To Give",
                                    collection: user_first.collections.where(name: "All")[0],
                                    remote_photo_url: "https://www.chezfee.com/images/stories/virtuemart/product/petit-boite-metal-coeur-lion1-chezfee1.jpg",
                                    category: Category.where(name: "Autres")[0])

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

  user6 = User.create(        username: "Chuck",
                              email: "cn@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/chuck.jpg"))

  user7 = User.create(        email: "jpheos@dividi.fr", password: '123456', password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jpheos.jpeg"))

  user8 = User.create(        username: "Titouan",
                              email: "tm@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/titouan.jpeg"))

  user9 = User.create(        username: "Mike Horn",
                              email: "mh@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/mike.jpg"))

  user10 = User.create(        username: "Mark",
                              email: "mz@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/mark.jpg"))

  user11 = User.create(        username: "Kevin",
                              email: "kc@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/kev.png"))


  user12 = User.create(        username: "Mat",
                              email: "mc@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/mat.jpeg"))


   jane = User.create(        username: "Jennifer",
                              email: "jm@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jane.jpg"))

   jain = User.create(        username: "Jain",
                              email: "j@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/jain.jpg"))

    nico = User.create(        username: "Nicolas H.",
                              email: "nh@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/nico.jpeg"))

    user9  = User.create(        username: "Stefan S.",
                              email: "ss@dividi.fr",
                              password: '123456',
                              password_confirmation: '123456',
                              avatar: File.open("#{Rails.root}/app/assets/images/images_seed/stefansagmeister.jpg"))


  test_landscape_image = Item.create( name: "Tente familiale",
                                      description: "5 places avec un hauvent",
                                      verbe: "To Lend",
                                      collection: user_second.collections.where(name: "All")[0],
                                      remote_photo_url: "https://www.voyagesetenfants.com/wp-content/uploads/2017/05/P1130541-cmp.jpg",
                                      category: Category.where(name: "Camping")[0])

  art_guerre = Item.create( name: "L'art de la guerre - Sun Tzu",
                            verbe: "To Lend",
                            collection: user_second.collections.where(name: "All")[0],
                            photo: File.open("#{Rails.root}/app/assets/images/images_seed/art_guerre.jpeg"),
                            category: Category.where(name: "Livres")[0])

  appareil_raclette = Item.create(name: "Appareil à raclette 8 personnes",
                                  verbe: "To Lend",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/raclette.jpg"),
                                  category: Category.where(name: "Cuisine")[0])

  radeau = Item.create(name: "Radeau ancien",
                                  price_cents: 1000,
                                  verbe: "To Rent",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/radeau.jpg"),
                                  category: Category.where(name: "Véhicules")[0])


  barbecue = Item.create(name: "Barbecue braséro Boston",
                                  price_cents: 700,
                                  verbe: "To Rent",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/barbecue2.jpg"),
                                  category: Category.where(name: "Cuisine")[0])

  mini_babyfoot = Item.create(name: "Mini Babyfoot",
                                  price_cents: 500,
                                  verbe: "To Sell",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/minibabyfoot.jpg"),
                                  category: Category.where(name: "Autres")[0])

  jumanji = Item.create(name: "Jumanji game",
                                  verbe: "To Give",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/jumanji.jpg"),
                                  category: Category.where(name: "Jeux")[0])



  miroir = Item.create(           name: "Miroir",
                                  verbe: "To Sell",
                                  price_cents: 2000,
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/miroir.jpg"),
                                  category: Category.where(name: "Meubles")[0])

  lampes = Item.create(           name: "Lampes et Lustres",
                                  verbe: "To Give",
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/lampes.jpg"),
                                  category: Category.where(name: "Meubles")[0])

  iphone = Item.create(           name: "Iphone",
                                  verbe: "To Sell",
                                  price_cents: 22000,
                                  collection: user_second.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/iphone.jpg"),
                                  category: Category.where(name: "Multimédia")[0])

  msi = Item.create(              name: "Ordi MSI",
                                  verbe: "To Sell",
                                  price_cents: 60000,
                                  collection: user7.collections.where(name: "All")[0],
                                  photo: File.open("#{Rails.root}/app/assets/images/images_seed/msi.jpg"),
                                  category: Category.where(name: "Multimédia")[0])




  Reminder.create(user: user_first, item: art_guerre)

  puts "#{User.all.size} users, #{Collection.all.size} collections, #{Item.all.size} items, #{Reminder.all.size} reminders in database !"

  puts "Creating networks and links..."

  # User 1 have all people as friends
  link1 = NetworkUser.create(user: user_second, network: user_first.networks.where(name: "Tous")[0])
  link1reverse = NetworkUser.create(user: user_first, network: user_second.networks.where(name: "Tous")[0])

  link2 = NetworkUser.create(user: user_third, network: user_first.networks.where(name: "Tous")[0])
  link2reverse = NetworkUser.create(user: user_first, network: user_third.networks.where(name: "Tous")[0])

  link3 = NetworkUser.create(user: user_fourth, network: user_first.networks.where(name: "Tous")[0])
  link3reverse = NetworkUser.create(user: user_first, network: user_fourth.networks.where(name: "Tous")[0])

  link4 = NetworkUser.create(user: user7, network: user_first.networks.where(name: "Tous")[0])
  link4reverse = NetworkUser.create(user: user_first, network: user7.networks.where(name: "Tous")[0])

  link_friend_request = NetworkUser.create(user: user_first, status: "pending", network: user8.networks.where(name: "Tous")[0])

  # confirmation des emails
  User.all.update_all confirmed_at: DateTime.now



puts "#{Share.all.size} table shared, #{Network.all.size} networks declared, #{NetworkUser.all.size} links network-user in database !"



