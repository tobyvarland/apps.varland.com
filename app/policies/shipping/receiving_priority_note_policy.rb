class Shipping::ReceivingPriorityNotePolicy < ApplicationPolicy

  def index?
    return true if user.present?
  end

  def create?
    return true if user.present?
  end

  def destroy?
    super || (user && user.id == object.requested_by_user_id )
  end

  def update?
    return true if user.present?
  end
  
end