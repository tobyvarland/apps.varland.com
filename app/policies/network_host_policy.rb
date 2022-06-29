class NetworkHostPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.permission.super_admin || user.permission.employee_notes == 3
        scope.all
      else
        scope.entered_by(user.id)
      end
    end
  end

  def index?
    true
  end

  def create?
    is_it? || is_super_admin?
  end

  def update?
    is_it? || is_super_admin?
  end

  def destroy?
    is_it? || is_super_admin?
  end

end