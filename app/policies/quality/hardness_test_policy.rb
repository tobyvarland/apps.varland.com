class Quality::HardnessTestPolicy < ApplicationPolicy

  def index?
    super || (user && user.permission && user.permission.hardness_tests >= 1)
  end

  def create?
    super || (user && user.permission && user.permission.hardness_tests >= 2)
  end

  def update?
    super || (user && user.permission && (user.permission.hardness_tests > 2 || user.id == object.user_id))
  end

  def destroy?
    super || (user && user.permission && user.permission.hardness_tests == 3)
  end

  def deleted?
    destroy?
  end

  def restore?
    destroy?
  end
  
end