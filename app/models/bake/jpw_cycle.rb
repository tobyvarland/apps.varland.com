class Bake::JpwCycle < Bake::Cycle

  # Class constants.
  REQUIRES_BAKE_PROFILE = true

  # Instance methods.

  # Returns cycle type.
  def cycle_type
    super.upcase
  end

end