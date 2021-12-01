class RecordsController < ApplicationController

  has_scope :for_record_type
  has_scope :for_device
  has_scope :due_within_days
  has_scope :due_on_or_before
  has_scope :for_data_type
  has_scope :for_responsibility

  def upcoming
    parse_filter_params
    filters_to_cookies
    begin
      @pagy, @assignments = pagy(apply_scopes(Records::Assignment.for_active_device.with_due_date), items: 50)
    rescue
      @pagy, @assignments = pagy(apply_scopes(Records::Assignment.for_active_device.with_due_date), items: 50, page: 1)
    end
  end

end