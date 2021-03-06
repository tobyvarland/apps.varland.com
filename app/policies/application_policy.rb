class ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def is_super_admin?
    return false unless user && user.permission
    user && user.permission.super_admin
  end

  def is_it?
    return false unless user
    ["toby.varland@varland.com", "john.mcguire@varland.com", "mark.strader@varland.com"].include? user.email
  end

  def require_permission_gte(permission, value, options = {})
    return false unless user && user.permission
    permission_value = user.permission.send(permission)
    allow_owner = options.fetch :allow_owner, false
    if allow_owner
      is_super_admin? || permission_value >= value || user.id == record.user_id
    else
      is_super_admin? || permission_value >= value
    end
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