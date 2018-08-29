def collections_creation(user)
  collections = %w(Bibliothèque Bricolage Garage High-tech Autres)

  collections.each do |collection|
    Collection.create(name: collection, user: user)
  end
end

def networks_creation(user)
  networks = %w(Tous Famille Amis Travail Bridge)

  networks.each do |network|
    Network.create(name: network, user: user)
  end

end
