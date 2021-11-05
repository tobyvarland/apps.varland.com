class EmployeeNotePolicy < ApplicationPolicy

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
    return false unless user
    require_permission_gte(user.permission.employee_notes, 1)
  end

  def create?
    return false unless user
    require_permission_gte(user.permission.employee_notes, 2)
  end

  def update?
    return false unless user
    require_permission_gte(user.permission.employee_notes, 3, allow_owner: true)
  end

  def destroy?
    return false unless user
    require_permission_gte(user.permission.employee_notes, 3)
  end

  def show?
    update?
  end

  def add_attachment?
    update?
  end

  def delete_attachment?
    update?
  end

  def add_comment?
    update?
  end

  def delete_comment?
    destroy?
  end

end