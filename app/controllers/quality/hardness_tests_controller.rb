class Quality::HardnessTestsController < ApplicationController

  before_action :set_hardness_test, only: %i[ show edit update destroy ]
  before_action :parse_filter_params, only: %i[ index deleted ]

  has_scope :with_shop_order, only: [:index, :deleted]
  has_scope :with_part, only: [:index, :deleted]

  # GET /quality/hardness_tests or /quality/hardness_tests.json
  def index
    authorize Quality::HardnessTest
    begin
      @pagy, @hardness_tests = pagy(apply_scopes(Quality::HardnessTest.includes(:user, :shop_order).all), items: 2)
    rescue
      @pagy, @hardness_tests = pagy(apply_scopes(Quality::HardnessTest.includes(:user, :shop_order).all), items: 2, page: 1)
    end
    @all_hardness_tests = apply_scopes(Quality::HardnessTest.includes(:user, :shop_order).all)
  end

  # GET /quality/hardness_tests or /quality/hardness_tests.json
  def deleted
    authorize Quality::HardnessTest
    begin
      @pagy, @hardness_tests = pagy(apply_scopes(Quality::HardnessTest.unscoped.discarded.includes(:user, :shop_order).all), items: 100)
    rescue
      @pagy, @hardness_tests = pagy(apply_scopes(Quality::HardnessTest.unscoped.discarded.includes(:user, :shop_order).all), items: 100, page: 1)
    end
  end

  # GET /quality/hardness_tests/new
  def new
    authorize Quality::HardnessTest
    @hardness_test = Quality::HardnessTest.new(user_id: current_user.id, is_rework: false, tested_on: Date.current)
  end

  # POST /quality/hardness_tests or /quality/hardness_tests.json
  def create
    @hardness_test = Quality::HardnessTest.new(hardness_test_params)
    authorize @hardness_test
    if @hardness_test.save 
      redirect_to quality_hardness_tests_url, notice: "Hardness Test was successfully created."
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def restore
    @hardness_test = Quality::HardnessTest.unscoped.find(params[:id])
    authorize @hardness_test
    @hardness_test.undiscard
    redirect_to quality_hardness_tests_url, notice: "Hardness test was successfully restored."
  end

  # DELETE /quality/hardness_tests/1 or /quality/hardness_tests/1.json
  def destroy
    authorize @hardness_test
    @hardness_test.discard
    redirect_to quality_hardness_tests_url, notice: "Hardness test was successfully deleted."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_hardness_test
      @hardness_test = Quality::HardnessTest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hardness_test_params
      params.require(:quality_hardness_test).permit(:user_id, :shop_order_id, :shop_order_number, :raw_test_id, :tested_on, :load, :is_rework, :test_type, :piece_1, :piece_2, :piece_3, :piece_4, :piece_5)
    end
end
