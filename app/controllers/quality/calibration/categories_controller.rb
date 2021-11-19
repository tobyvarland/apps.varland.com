class Quality::Calibration::CategoriesController < ApplicationController
  before_action :set_quality_calibration_category, only: %i[ show edit update destroy ]

  # GET /quality/calibration/categories or /quality/calibration/categories.json
  def index
    @quality_calibration_categories = Quality::Calibration::Category.all
  end

  # GET /quality/calibration/categories/1 or /quality/calibration/categories/1.json
  def show
  end

  # GET /quality/calibration/categories/new
  def new
    @quality_calibration_category = Quality::Calibration::Category.new
  end

  # GET /quality/calibration/categories/1/edit
  def edit
  end

  # POST /quality/calibration/categories or /quality/calibration/categories.json
  def create
    @quality_calibration_category = Quality::Calibration::Category.new(quality_calibration_category_params)

    respond_to do |format|
      if @quality_calibration_category.save
        format.html { redirect_to @quality_calibration_category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @quality_calibration_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quality_calibration_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quality/calibration/categories/1 or /quality/calibration/categories/1.json
  def update
    respond_to do |format|
      if @quality_calibration_category.update(quality_calibration_category_params)
        format.html { redirect_to @quality_calibration_category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @quality_calibration_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quality_calibration_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quality/calibration/categories/1 or /quality/calibration/categories/1.json
  def destroy
    @quality_calibration_category.destroy
    respond_to do |format|
      format.html { redirect_to quality_calibration_categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quality_calibration_category
      @quality_calibration_category = Quality::Calibration::Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quality_calibration_category_params
      params.require(:quality_calibration_category).permit(:name, :calibration_frequency, :instructions_url, :two_point_low_value, :two_point_high_value, :calculate_offset_and_gain, :require_offset, :require_gain, :enable_notifications, :discarded_at)
    end
end
