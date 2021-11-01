class ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def is_super_admin?
    user && user.permission.super_admin
  end

  def index?
    is_super_admin?
  end

  def show?
    is_super_admin?
  end

  def create?
    is_super_admin?
  end

  def new?
    create?
  end

  def update?
    is_super_admin?
  end

  def edit?
    update?
  end

  def destroy?
    is_super_admin?
  end

  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

  end

end