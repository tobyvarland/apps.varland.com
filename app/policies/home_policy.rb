class HomePolicy < Struct.new(:user, :home)

  def is_super_admin?
    return false unless user && user.permission
    user && user.permission.super_admin
  end

  def require_permission_gte(permission, value)
    return false unless user && user.permission
    permission_value = user.permission.send(permission)
    is_super_admin? || permission_value >= value
  end

  def view_final_inspection?
    require_permission_gte :final_inspection, 1
  end

  def record_final_inspection?
    require_permission_gte :final_inspection, 2
  end

  def sidekiq?
    return user && user.permission.super_admin
  end

end