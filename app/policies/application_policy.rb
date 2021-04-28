class ApplicationPolicy
  
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user && user.permission.super_admin
  end

  def show?
    user && user.permission.super_admin
  end

  def create?
    user && user.permission.super_admin
  end

  def new?
    create?
  end

  def update?
    user && user.permission.super_admin
  end

  def edit?
    update?
  end

  def destroy?
    user && user.permission.super_admin
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