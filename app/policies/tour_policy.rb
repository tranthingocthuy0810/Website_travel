class TourPolicy < ApplicationPolicy
    def index?
        true
    end

    def show?
        true
    end 

    def destroy?
        true
    end

    def create?
        # Allow admins and managers to create posts
        user.admin? || user.manager?
    end

    def update?
        # Allow admins and managers to update posts
        user.admin? || user.manager?
    end

    class Scope < Scope
        def resolve
            scope.all
        end
    end
end
