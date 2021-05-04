class AttachmentsController < ApplicationController

  before_action :set_attachment, only: %i[ edit update destroy ]

  def edit
  end

  def update
    if @attachment.update(attachment_params)
      redirect_to @attachment.attachable
    else
      redirect_to @attachment.attachable, error: "Error updating attachment. Please try again or contact IT for help."
    end
  end

  def destroy
    @attachment.destroy
    redirect_to @attachment.attachable
  end

  private
  
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:attachable_id, :attachable_type, :name, :description)
    end

end