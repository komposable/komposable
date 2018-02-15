module ActiveStorage
  class BlobPolicy < ApplicationPolicy
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
      # TODO: limit to admins
      true
    end

    def update?
      # TODO: limit to admins
      true
    end

    def destroy?
      # TODO: limit to admins
      true
    end
  end
end
