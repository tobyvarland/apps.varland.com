class Projects::CategoriesController < ApplicationController
  before_action :set_projects_category, only: %i[ show edit update destroy ]

  # GET /projects/categories or /projects/categories.json
  def index
    @projects_categories = Projects::Category.all
  end

  # GET /projects/categories/1 or /projects/categories/1.json
  def show
  end

  # GET /projects/categories/new
  def new
    @projects_category = Projects::Category.new
  end

  # GET /projects/categories/1/edit
  def edit
  end

  # POST /projects/categories or /projects/categories.json
  def create
    @projects_category = Projects::Category.new(projects_category_params)

    respond_to do |format|
      if @projects_category.save
        format.html { redirect_to @projects_category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @projects_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @projects_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/categories/1 or /projects/categories/1.json
  def update
    respond_to do |format|
      if @projects_category.update(projects_category_params)
        format.html { redirect_to @projects_category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @projects_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @projects_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/categories/1 or /projects/categories/1.json
  def destroy
    @projects_category.destroy
    respond_to do |format|
      format.html { redirect_to projects_categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_category
      @projects_category = Projects::Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def projects_category_params
      params.require(:projects_category).permit(:system_id, :name, :abbreviation, :last_number_used, :comment_sections, :use_priorities, :use_tasks, :use_time_tracking, :use_reviews, :use_percent_complete, :allow_children, :allow_requests, :send_feedback, :use_due_date)
    end
end
