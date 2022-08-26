class HistorianController < ApplicationController

  def msd_annotation
    new_record = Records::QuickCheck.new user: current_user, result_on: Date.current
    new_record.device = Records::Device.where(name: "Waste Water").first
    new_record.reason_code = Records::ReasonCode.where(name: "Verification").first
    record_type_name = nil
    case params[:annotation][:type].to_sym
    when :eight_hour
      record_type_name = "Every Shift Final pH Verification"
    when :weekly
      record_type_name = "Weekly Final pH Verification"
    when :calibration
      record_type_name = "Final pH Probe Calibration"
    end
    new_record.record_type = Records::RecordType.where(name: record_type_name).first
    return unless new_record.valid?
    if new_record.save
      redirect_back fallback_location: root_path, notice: "Annotation added to MSD chart in historian."
    else
      redirect_back fallback_location: root_path, alert: "Failed to add annotation to MSD chart. Contact IT for help."
    end
  end

end