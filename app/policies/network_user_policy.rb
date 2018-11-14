# frozen_string_literal: true

class NetworkUserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.network.user == user
  end

  def accept?
    record.user == user || record.network.user == user
  end

  def destroy?
    accept?
  end

  def destroy_all_links?
    accept?
  end
end
