class Quality::RejectTagPolicy < ApplicationPolicy

  def index?
    super || (user && user.permission && user.permission.reject_tags >= 1)
  end

  def create?
    super || (user && user.permission && user.permission.reject_tags >= 2)
  end

  def update?
    super || (user && user.permission && (user.permission.reject_tags > 2 || user.id == record.user_id))
  end

  def destroy?
    super || (user && user.permission && user.permission.reject_tags == 3)
  end

  def add_comment?
    update?
  end

  def delete_comment?
    user && user.permission && (user.permission.super_admin || user.permission.reject_tags == 3)
  end

  def shop_order_partial_tag?
    show?
  end

end