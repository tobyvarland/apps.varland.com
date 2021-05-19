class VCMSController < ApplicationController

  def link_part_spec
    VCMS::LinkPartSpecJob.perform_later current_user.username, params[:customer], params[:process], params[:part], params[:sub]
    redirect_back fallback_location: root_path
  end

end