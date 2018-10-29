# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: user.friends_items.pluck(:id))
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    user == record.collection.user || user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
