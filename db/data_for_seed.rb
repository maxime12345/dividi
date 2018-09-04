def collections_creation(user)
  collections = %w(All)

  collections.each do |collection|
    Collection.create(name: collection, user: user)
  end

end

def networks_creation(user)
  networks = %w(Tous)

  networks.each do |network|
    Network.create(name: network, user: user)
  end
end

def share_creation(user)
  user.collections.each do |collection|
    share = Share.create(network: user.default_network, collection: collection)
  end
end
