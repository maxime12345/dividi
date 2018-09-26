class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: user.collections.pluck(:id))
    end
  end

  def create?
    true
  end

  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
