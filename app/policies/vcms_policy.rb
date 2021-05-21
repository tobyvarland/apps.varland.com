class VCMSPolicy < Struct.new(:user, :vcms)

  def part_search?
    return !user.blank?
  end

  def part_history_search?
    return part_search?
  end

  def quote_search?
    return user && (user.permission.super_admin || user.employee_number >= 700)
  end

  def recent_customers?
    return user && (user.permission.super_admin || user.employee_number >= 700)
  end

end