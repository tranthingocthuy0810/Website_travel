class ListTourPolicy < ApplicationPolicy
    def index?
        true
    end
 
 
    def show?
        true
    end
 
 
    def destroy?
        user.admin?
    end
 
 
    def create?
        # Allow admins and managers to create tours
        user.admin?
    end


    def update?
        # Allow admins and managers to update tours
        user.admin? || user.manager?
    end

    class Scope < Scope
        def resolve
          scope.all
        end
    end
 end
