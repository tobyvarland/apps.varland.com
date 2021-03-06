class Quality::HardnessTestPolicy < ApplicationPolicy

  def index?
    super || (user && user.permission && user.permission.hardness_tests >= 1)
  end

  def create?
    true #super || (user && user.permission && user.permission.hardness_tests >= 2)
  end

  def update?
    super || (user && user.permission && (user.permission.hardness_tests > 2 || user.id == record.user_id))
  end

  def destroy?
    super || (user && user.permission && (user.permission.hardness_tests > 2 || user.id == record.user_id))
  end

  def show?
    index?
  end

  def deleted?
    index?
  end

  def restore?
    destroy?
  end

  def add_comment?
    is_super_admin? || (user && user.permission && (user.permission.hardness_tests >= 2))
  end

  def delete_comment?
    is_super_admin? || (user && user.permission && (user.permission.super_admin || user.permission.hardness_tests == 3))
  end

end