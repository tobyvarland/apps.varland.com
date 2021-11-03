class EmployeeNoteSubjectsController < ApplicationController
  before_action :set_employee_note_subject, only: %i[ show edit update destroy ]

  # GET /employee_note_subjects or /employee_note_subjects.json
  def index
    @employee_note_subjects = EmployeeNoteSubject.all
  end

  # GET /employee_note_subjects/1 or /employee_note_subjects/1.json
  def show
  end

  # GET /employee_note_subjects/new
  def new
    @employee_note_subject = EmployeeNoteSubject.new
  end

  # GET /employee_note_subjects/1/edit
  def edit
  end

  # POST /employee_note_subjects or /employee_note_subjects.json
  def create
    @employee_note_subject = EmployeeNoteSubject.new(employee_note_subject_params)

    respond_to do |format|
      if @employee_note_subject.save
        format.html { redirect_to @employee_note_subject, notice: "Employee note subject was successfully created." }
        format.json { render :show, status: :created, location: @employee_note_subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_note_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_note_subjects/1 or /employee_note_subjects/1.json
  def update
    respond_to do |format|
      if @employee_note_subject.update(employee_note_subject_params)
        format.html { redirect_to @employee_note_subject, notice: "Employee note subject was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_note_subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_note_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_note_subjects/1 or /employee_note_subjects/1.json
  def destroy
    @employee_note_subject.destroy
    respond_to do |format|
      format.html { redirect_to employee_note_subjects_url, notice: "Employee note subject was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_note_subject
      @employee_note_subject = EmployeeNoteSubject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_note_subject_params
      params.require(:employee_note_subject).permit(:user_id, :employee_note_id, :note_type)
    end
end
