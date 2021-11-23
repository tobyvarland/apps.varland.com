class Groov::LogPolicy < ApplicationPolicy

  def index?
    return true
  end

  def live?
    return true
  end

  def create?
    return true
  end

  def reclassify?
    is_super_admin?
  end

  def destroy?
    is_super_admin?
  end

end