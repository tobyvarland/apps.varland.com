class Shipping::ReceivingPriorityNotesController < ApplicationController

  before_action :set_shipping_receiving_priority_note, only: %i[ update destroy ]

  def index
    authorize Shipping::ReceivingPriorityNote
    @auto_refresh = 299
    @shipping_receiving_priority_notes = Shipping::ReceivingPriorityNote.incomplete.order(:created_at)
  end

  def new
    authorize Shipping::ReceivingPriorityNote
    @shipping_receiving_priority_note = Shipping::ReceivingPriorityNote.new
    @shipping_receiving_priority_note.requested_by_user = current_user
  end

  def create
    @shipping_receiving_priority_note = Shipping::ReceivingPriorityNote.new(shipping_receiving_priority_note_params)
    authorize @shipping_receiving_priority_note
    if @shipping_receiving_priority_note.save
      redirect_to shipping_receiving_priority_notes_url
    else
      render :new
    end
  end

  def update
    authorize @shipping_receiving_priority_note
    if @shipping_receiving_priority_note.update(shipping_receiving_priority_note_params)
      # Shipping::ReceivingPriorityNoteMailer.with(note: @shipping_receiving_priority_note).completion_email.deliver_now
      redirect_to shipping_receiving_priority_notes_url
    else
      redirect_to shipping_receiving_priority_notes_url, alert: "Error updating note. Please try again or contact IT for help."
    end
  end

  def destroy
    authorize @shipping_receiving_priority_note
    @shipping_receiving_priority_note.destroy
    redirect_to shipping_receiving_priority_notes_url
  end

  private
    
    def set_shipping_receiving_priority_note
      @shipping_receiving_priority_note = Shipping::ReceivingPriorityNote.find(params[:id])
    end

    def shipping_receiving_priority_note_params
      params.require(:shipping_receiving_priority_note).permit(:request_type, :request_details, :requested_by_user_id, :completed_by_user_id, :completed_at)
    end

end