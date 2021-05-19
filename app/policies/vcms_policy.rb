class VCMSPolicy < Struct.new(:user, :vcms)

  def part_search?
    return !user.blank?
  end

  def recent_customers?
    return user && (user.permission.super_admin || user.employee_number >= 700)
  end

end