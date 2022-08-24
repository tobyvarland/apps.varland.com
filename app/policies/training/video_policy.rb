class Training::VideoPolicy < ApplicationPolicy

  def index?
    return true
  end

  def show?
    index?
  end

  def create?
    is_it?
  end

  def destroy?
    is_it?
  end

  def update?
    is_it?
  end

end