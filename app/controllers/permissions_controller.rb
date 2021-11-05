class PermissionsController < ApplicationController

  before_action :set_permission, only: %i[ update ]

  def index
    authorize Permission
    @permissions = Permission.includes(:user).for_active_employees.by_employee
  end

  def update
    authorize @permission
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to permissions_url }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { redirect_to permissions_url, alert: "Failed to update permissions for #{@permission.user.name}." }
        format.json { render :show, status: :unprocessable_entity, location: @permission }
      end
    end
  end

  private

    def set_permission
      @permission = Permission.find(params[:id])
    end

    def permission_params
      params.require(:permission).permit(:user_id, :super_admin, :reject_tags, :hardness_tests, :shift_notes, :employee_notes)
    end

end