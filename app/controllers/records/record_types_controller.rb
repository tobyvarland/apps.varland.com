class Records::RecordTypesController < ApplicationController

  before_action :set_record_type, only: %i[ show edit update destroy ]

  def index
    @record_types = Records::RecordType.by_name
  end

  def show
  end

  def new
    @record_type = Records::RecordType.new
  end

  def edit
  end

  def create
    @record_type = Records::RecordType.new(record_type_params)
    if @record_type.save
      redirect_to records_record_types_url, notice: "Record type was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @record_type.update(record_type_params)
      redirect_to @record_type, notice: "Record type was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record_type.discard
    redirect_to records_record_types_url, notice: "Record type was successfully destroyed."
  end

  private

    def set_record_type
      @record_type = Records::RecordType.find(params[:id])
    end

    def record_type_params
      params.require(:records_record_type).permit(:name,
                                                            :frequency,
                                                            :url,
                                                            :record_subclass,
                                                            :expected_low,
                                                            :expected_high,
                                                            :rockwell_scale,
                                                            :test_block_hardness,
                                                            :test_block_serial,
                                                            :max_error,
                                                            :max_repeatability,
                                                            :data_type,
                                                            :responsibility,
                                                            assignments_attributes: [:id, :device_id, :_destroy])
    end

end