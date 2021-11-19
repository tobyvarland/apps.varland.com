class Quality::Calibration::CalibrationAdminPolicy < ApplicationPolicy
  def index?
    require_permission_gte(:calibrations, 1)
  end

  def create?
    require_permission_gte(:calibrations, 3)
  end

  def update?
    require_permission_gte(:calibrations, 3)
  end

  def destroy?
    require_permission_gte(:calibrations, 3)
  end
end
