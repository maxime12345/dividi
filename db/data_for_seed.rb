def collections_creation(user)
  collections = %w(Bibliothèque Bricolage Garage High-tech Autres)

  collections.each do |collection|
    Collection.create(name: collection, user: user)
  end
end
