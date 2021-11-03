class VarlandPlating

  def self.current_shift
    case Time.current.hour
    when 0..6
      return 2
    when 7..18
      return 1
    when 19..23
      return 2
    end
  end

  def self.current_production_date
    return Date.current - ((current_shift == 2 && Time.current.hour < 7) ? 1 : 0).days
  end

end