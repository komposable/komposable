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
    common_attributes = %i[
      email
      first_name last_name
      password password_confirmation
    ]

    if at_least_admin?
      common_attributes + %i[role]
    else
      common_attributes
    end
  end
end
