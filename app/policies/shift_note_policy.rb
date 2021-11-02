class ShiftNotePolicy < ApplicationPolicy

  def index?
    is_super_admin? || user.permission.shift_notes > 0
  end

  def create?
    is_super_admin? || user.permission.shift_notes > 1
  end

  def update?
    is_super_admin? || user.permission.shift_notes > 2 || user.id == record.user_id
  end

  def destroy?
    is_super_admin? || user.permission.shift_notes > 2
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