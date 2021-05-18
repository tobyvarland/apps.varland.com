class VCMSPolicy < Struct.new(:user, :vcms)

  def recent_customers?
    return user && (user.permission.super_admin || user.employee_number >= 700)
  end

end