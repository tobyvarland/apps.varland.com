class EmployeeNotesController < ApplicationController

  before_action :set_employee_note, only: %i[ show edit update destroy add_attachment ]
  before_action :parse_filter_params, only: %i[ index ]

  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :entered_by
  has_scope :with_search_term
  has_scope :has_comments
  has_scope :has_any_attachments
  has_scope :sorted_by, default: "newest", allow_blank: true

  def index
    authorize(EmployeeNote)
    filters_to_cookies :show_filters
    begin
      @pagy, @employee_notes = pagy(apply_scopes(policy_scope(EmployeeNote).includes(:user).all), items: 100)
    rescue
      @pagy, @employee_notes = pagy(apply_scopes(policy_scope(EmployeeNote).includes(:user).all), items: 100, page: 1)
    end
    @all_employee_notes = apply_scopes(policy_scope(EmployeeNote).includes(:user).all)
  end

  def show
    authorize(@employee_note)
    @comment = current_user.comments.build if current_user
  end

  def new
    authorize(EmployeeNote)
    @employee_note = EmployeeNote.new(user_id: current_user.id, note_on: Date.current)
  end

  def edit
    authorize(@employee_note)
  end

  def create
    @employee_note = EmployeeNote.new(employee_note_params)
    authorize(@employee_note)
    if @employee_note.save
      redirect_to @employee_note, notice: "Employee note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@employee_note)
    if @employee_note.update(employee_note_params)
      redirect_to @employee_note, notice: "Employee note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@employee_note)
    @employee_note.discard
    redirect_to employee_notes_url, notice: "Employee note was successfully destroyed."
  end

  def add_attachment
    authorize @employee_note
    params[:uploads].each do |upload|
      attachment = @employee_note.attachments.new
      attachment.file.attach(upload)
      attachment.save
    end
    redirect_to(@employee_note)
  end

  private

    def set_employee_note
      @employee_note = policy_scope(EmployeeNote).find(params[:id])
    end

    def employee_note_params
      params.require(:employee_note).permit(:user_id,
                                            :note_on,
                                            :notes,
                                            :discarded_at,
                                            attachments_attributes: [:id, :name, :description, :file, :_destroy], 
                                            employee_note_subjects_attributes: [:id, :user_id, :note_type, :_destroy])
    end

end
