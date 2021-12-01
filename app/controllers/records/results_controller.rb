class Records::ResultsController < ApplicationController

  before_action :set_result, only: %i[ show edit update destroy ]

  has_scope :sorted_by, default: "newest", allow_blank: true
  has_scope :for_record_type
  has_scope :for_device
  has_scope :for_reason_code
  has_scope :for_user
  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :with_offset
  has_scope :with_gain
  has_scope :with_expected_low
  has_scope :with_expected_high
  has_scope :with_actual_low
  has_scope :with_actual_high
  has_scope :with_reading
  has_scope :with_reading_average
  has_scope :with_reading_error
  has_scope :with_reading_repeatability
  has_scope :with_reading_error_valid
  has_scope :with_reading_repeatability_valid
  has_scope :with_is_valid
  has_scope :with_temperature
  has_scope :with_collection_amount
  has_scope :with_collection_hours
  has_scope :with_collection_rate
  has_scope :with_collection_rate_valid
  has_scope :for_data_type
  has_scope :for_responsibility

  def index
    parse_filter_params
    filters_to_cookies
    begin
      @record_type = Records::RecordType.find(params[:for_record_type])
    rescue
      @record_type = nil
    end
    begin
      @pagy, @results = pagy(apply_scopes(Records::Result.all), items: 50)
    rescue
      @pagy, @results = pagy(apply_scopes(Records::Result.all), items: 50, page: 1)
    end
    if @record_type.nil?
      types = @results.map {|r| r.record_type_id}.uniq
      if types.length == 1
        @record_type = Records::RecordType.find(types[0])
      end
    end
  end

  def show
  end

  def new
    @result = Records::Result.new
  end

  def edit
  end

  def create
    @result = Records::Result.new(result_params)
    if @result.save
      redirect_back fallback_location: @result.record_type, notice: "Record was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @result.update(result_params)
      redirect_to records_results_url, notice: "Record was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @result.discard
    redirect_to records_results_url, notice: "Record was successfully destroyed."
  end

  private

    def set_result
      @result = Records::Result.find(params[:id])
    end

    def result_params
      params.require(:records_result).permit(:type,
                                                  :device_id,
                                                  :record_type_id,
                                                  :user_id,
                                                  :reason_code_id,
                                                  :result_on,
                                                  :expected_low,
                                                  :actual_low,
                                                  :expected_high,
                                                  :actual_high,
                                                  :offset,
                                                  :gain,
                                                  :rockwell_scale,
                                                  :test_block_hardness,
                                                  :test_block_serial,
                                                  :max_error,
                                                  :max_repeatability,
                                                  :reading_1,
                                                  :reading_2,
                                                  :temperature,
                                                  :collection_1_amount,
                                                  :collection_1_hours,
                                                  :collection_2_amount,
                                                  :collection_2_hours)
    end

end