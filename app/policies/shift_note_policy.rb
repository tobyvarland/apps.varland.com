class ShiftNotePolicy < ApplicationPolicy

  def index?
    require_permission_gte(:shift_notes, 1)
  end

  def create?
    require_permission_gte(:shift_notes, 2)
  end

  def update?
    require_permission_gte(:shift_notes, 3, allow_owner: true)
  end

  def destroy?
    require_permission_gte(:shift_notes, 3)
  end

  def add_attachment?
    update?
  end

  def delete_attachment?
    update?
  end

  def add_comment?
    create?
  end

  def delete_comment?
    destroy?
  end

end