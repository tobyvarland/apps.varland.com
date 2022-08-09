class Groov::LogsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user!, except: [:reclassify, :destroy]

  before_action :set_log, only: %i[ reclassify destroy ]

  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :for_controller
  has_scope :of_type
  has_scope :with_search_term
  has_scope :sorted_by, default: "newest", allow_blank: true

	def index
    authorize(Groov::Log)
    filters_to_cookies
    begin
      @pagy, @logs = pagy(apply_scopes(Groov::Log.all), items: 50)
    rescue
      @pagy, @logs = pagy(apply_scopes(Groov::Log.all), items: 50, page: 1)
    end
    @all_logs = apply_scopes(Groov::Log.all)
	end

  def live
    authorize(Groov::Log)
    @controller_name = params.fetch(:controller_name, nil)
    @logs = Groov::Log.for_controller(@controller_name).sorted_by("newest").limit(30)
  end

  def create
    authorize(Groov::Log)
    begin
      @log = Groov::Log.new(log_params)
      @log.extract_details
      result = @log.save
    rescue ActiveRecord::SubclassNotFound => e
      @log = Groov::Log.new(log_params_without_type)
      @log.type = "Groov::GroovLog"
      @log.extract_details
      result = @log.save
    end
    if result
      return head :created
    else
      return head :unprocessable_entity
    end
  end

  def reclassify
    authorize(Groov::Log)
    if Object.const_defined? @log.groov_data[:type]
      @log.type = @log.groov_data[:type]
      @log.save
      redirect_back fallback_location: groov_logs_url, notice: "Successfully reclassified log as #{@log.log_type}."
    else
      redirect_back fallback_location: groov_logs_url, alert: "Log could not be reclassified because specific definition not found."
    end
  end

  def destroy
    authorize(Groov::Log)
    @log.discard
    redirect_to groov_logs_url, notice: "Log successfull deleted."
  end

  private

    def set_log
      @log = Groov::Log.find(params[:id])
    end

    def log_params
      params.require(:groov_log).permit(:type, :controller_name, :log_at, :json_data)
    end

    def log_params_without_type
      params.require(:groov_log).permit(:controller_name, :log_at, :json_data)
    end

end