class VCMS::QualityController < ApplicationController

  before_action       :prevent_cache

  def final_inspect
    authorize :home, :view_final_inspection?
    @data = load_json "http://json400.varland.com/final_inspect_orders"
  end

  def final_inspect_completed
    authorize :home, :view_final_inspection?
    @data = load_json "http://json400.varland.com/final_inspect_orders"
  end

end