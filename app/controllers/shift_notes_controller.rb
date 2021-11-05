class ShiftNotesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :import
  skip_before_action :authenticate_user!, only: :import

  before_action :set_shift_note, only: %i[ show edit update destroy add_attachment ]
  before_action :parse_filter_params, only: %i[ index ]

  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :with_shift
  has_scope :with_department
  has_scope :entered_by
  has_scope :with_search_term
  has_scope :for_it
  has_scope :for_lab
  has_scope :for_maintenance
  has_scope :for_plating
  has_scope :for_qc
  has_scope :for_shipping
  has_scope :has_comments
  has_scope :has_any_attachments
  has_scope :sorted_by, default: "newest", allow_blank: true

  def index
    authorize(ShiftNote)
    filters_to_cookies :show_filters
    begin
      @pagy, @shift_notes = pagy(apply_scopes(ShiftNote.includes(:user).all), items: 100)
    rescue
      @pagy, @shift_notes = pagy(apply_scopes(ShiftNote.includes(:user).all), items: 100, page: 1)
    end
    @all_shift_notes = apply_scopes(ShiftNote.includes(:user).all)
  end

  def show
    authorize(@shift_note)
    @comment = current_user.comments.build if current_user
  end

  def new
    authorize(ShiftNote)
    @shift_note = ShiftNote.new(user_id: current_user.id, note_on: VarlandPlating.current_production_date, shift: VarlandPlating.current_shift)
  end

  def edit
    authorize(@shift_note)
  end

  def import
    @shift_note = ShiftNote.new(shift_note_params)
    if @shift_note.save
      head :ok
    else
      head :unprocessable_entity, errors: @shift_note.errors.full_messages
    end
  end

  def create
    @shift_note = ShiftNote.new(shift_note_params)
    authorize(@shift_note)
    if @shift_note.save
      redirect_to @shift_note, notice: "Shift note was successfully created."
    else
      render :new, status: :unprocessable_entity
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
                                         attachments_attributes: [:id, :name, :description, :file, :_destroy],
                                         comments_attributes: [:id, :user_id, :body, :comment_at, :file, :_destroy])
    end

end