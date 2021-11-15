class VCMSController < ApplicationController

  def link_part_spec
    VCMS::LinkPartSpecJob.perform_later current_user.username, params[:customer], params[:process], params[:part], params[:sub]
    # redirect_back fallback_location: root_path
    render json: true
  end

  def record_final_inspect
    authorize :home, :record_final_inspection?
    VCMS::RecordFinalInspectJob.perform_later current_user.username, params[:shop_order]
    redirect_back fallback_location: vcms_quality_final_inspect_path, notice: "Recorded final inspection on the System i for S.O. ##{params[:shop_order]}."
  end

end