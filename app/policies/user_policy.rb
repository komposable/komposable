class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    at_least_admin?
  end

  def create?
    at_least_admin?
  end

  def update?
    at_least_admin? || user == record
  end

  def destroy?
    at_least_admin?
  end

  def permitted_attributes
    if at_least_admin?
      %i[email first_name last_name role password password_confirmation]
    else
      %i[email first_name last_name password password_confirmation]
    end
  end
end
