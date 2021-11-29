class Quality::Calibration::CategoriesController < ApplicationController

  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    authorize(Quality::Calibration::Category)
    @categories = Quality::Calibration::Category.all
  end

  def new
    authorize(Quality::Calibration::Category)
    @category = Quality::Calibration::Category.new
  end

  def edit
    authorize(@category)
  end

  def create
    @category = Quality::Calibration::Category.new(category_params)
    authorize(@category)
    if @category.save
      redirect_to quality_calibration_categories_url, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@category)
    if @category.update(category_params)
      redirect_to quality_calibration_categories_url, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@category)
    @category.discard
    redirect_to quality_calibration_categories_url, notice: "Category was successfully destroyed."
  end

  private

    def set_category
      @category = Quality::Calibration::Category.find(params[:id])
    end

    def category_params
      params.require(:quality_calibration_category).permit(:name,
                                                           :calibration_frequency,
                                                           :instructions_url,
                                                           :two_point_low_value,
                                                           :two_point_high_value,
                                                           :calibration_method)
    end

end
