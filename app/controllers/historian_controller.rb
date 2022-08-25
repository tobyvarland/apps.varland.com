class HistorianController < ApplicationController

  def msd_annotation
    StoreMSDAnnotationJob.perform_later current_user.name, params[:annotation][:type].to_sym
    redirect_back fallback_location: root_path, notice: "Annotation added."
  end

end