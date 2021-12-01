class RecordsPolicy < Struct.new(:user, :records)

  def is_super_admin?
    return false unless user && user.permission
    user && user.permission.super_admin
  end

  def require_permission_gte(permission, value)
    return false unless user && user.permission
    permission_value = user.permission.send(permission)
    is_super_admin? || permission_value >= value
  end

  def view?
    require_permission_gte(:records, 1)
  end

  def data_entry?
    require_permission_gte(:records, 2)
  end

  def admin?
    require_permission_gte(:records, 3)
  end

end