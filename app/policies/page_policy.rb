class PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    # TODO: limit to admins
    true
  end

  def create?
    false
  end

  def update?
    # TODO: limit to admins
    true
  end

  def destroy?
    false
  end
end
