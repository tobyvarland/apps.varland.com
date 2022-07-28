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

  def clear_final_inspect
    authorize :home, :record_final_inspection?
    VCMS::ClearFinalInspectionJob.perform_later params[:shop_order]
    redirect_back fallback_location: vcms_quality_final_inspect_completed_path, notice: "Cleared final inspection on the System i for S.O. ##{params[:shop_order]}."
  end

  def clear_opto_code
    authorize :home, :record_final_inspection?
    VCMS::ClearOptoCodeJob.perform_now current_user.username, params[:opto_code][:shop_order], params[:opto_code][:load], params[:opto_code][:code], params[:opto_code][:timestamp], params[:opto_code][:ip]
    redirect_back fallback_location: vcms_quality_final_inspect_path, notice: "Removed Opto code on the System i for S.O. ##{params[:opto_code][:shop_order]}."
  end

end