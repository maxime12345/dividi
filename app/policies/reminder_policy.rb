class ReminderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    new?
  end

  def destroy?
    # première condition : le record est un rappel, deuxième condition: l'objet m'appartient (l'ordre est important)
    puts "debug record"
    p record
    puts "debug record.item"
    p record.item
    puts "debug record.item.collection"
    p record.item.collection
    puts "debug record.item.collection.user"
    p record.item.collection.user
    (record.user == user && record.item.nil?) || ( record.item.collection.user == user )
  end

  def new_outside?
    destroy?
  end

  def create_outside?
    destroy?
  end

  def new_item_outside?
    true
  end

  def create_item_outside?
    new_item_outside?
  end

  def accept?
    destroy?
  end

  def decline?
    destroy?
  end

end
