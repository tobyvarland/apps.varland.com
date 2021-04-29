class HomePolicy < Struct.new(:user, :home)

  def employee_notes?
    return user && (user.permission.super_admin || user.employee_number >= 600)
  end

end