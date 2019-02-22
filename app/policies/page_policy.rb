class PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    at_least_admin?
  end

  def create?
    false
  end

  def update?
    at_least_admin?
  end

  def destroy?
    false
  end
end
