class ShiftNotesController < ApplicationController

  before_action :set_shift_note, only: %i[ show edit update destroy add_attachment ]
  before_action :parse_filter_params, only: %i[ index ]

  has_scope :sorted_by, only: [:index], default: "newest"

  def index
    authorize(ShiftNote)
    filters_to_cookies
    if params[:sorted_by].blank?
      params[:sorted_by] = "newest"
      if params[:filters].blank?
        params[:filters] = { sorted_by: "newest" }
      else
        params[:filters][:sorted_by] = "newest"
      end
    end
    begin
      @pagy, @shift_notes = pagy(apply_scopes(ShiftNote.includes(:user).all), items: 100)
    rescue
      @pagy, @shift_notes = pagy(apply_scopes(ShiftNote.includes(:user).all), items: 100, page: 1)
    end
  end

  def show
    authorize(@shift_note)
    @comment = current_user.comments.build if current_user
  end

  def new
    authorize(ShiftNote)
    @shift_note = ShiftNote.new(user_id: current_user.id, note_on: Date.current)
  end

  def edit
    authorize(@shift_note)
  end

  def create
    @shift_note = ShiftNote.new(shift_note_params)
    authorize(@shift_note)
    if @shift_note.save
      redirect_to @shift_note, notice: "Shift note was successfully created."
    else
      render :new, status: :unprocessable_entityßß
    end
  end

  def update
    authorize(@shift_note)
    if @shift_note.update(shift_note_params)
      redirect_to @shift_note, notice: "Shift note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@shift_note)
    @shift_note.discard
    redirect_to shift_notes_url, notice: "Shift note was successfully destroyed."
  end

  def add_attachment
    authorize @shift_note
    params[:uploads].each do |upload|
      attachment = @shift_note.attachments.new
      attachment.file.attach(upload)
      attachment.save
    end
    redirect_to(@shift_note)
  end

  private

    def set_shift_note
      @shift_note = ShiftNote.find(params[:id])
    end

    def shift_note_params
      params.require(:shift_note).permit(:user_id,
                                         :note_on,
                                         :shift,
                                         :department,
                                         :notes,
                                         :is_for_it,
                                         :is_for_lab,
                                         :is_for_maintenance,
                                         :is_for_plating,
                                         :is_for_qc,
                                         :is_for_shipping,
                                         :discarded_at,
                                         attachments_attributes: [:id, :name, :description, :file, :_destroy])
    end

end