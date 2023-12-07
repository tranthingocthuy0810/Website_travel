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
        user.admin? || user.manager?
    end


    def update?
        # Allow admins and managers to update tours
        user.admin? || user.manager?
    end
 end
