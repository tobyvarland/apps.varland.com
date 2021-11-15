class VCMS::QualityController < ApplicationController

  before_action       :prevent_cache

  def final_inspect
    authorize :home, :view_final_inspection?
    @jobs = load_json "http://vcmsapi.varland.com/final_inspect_list"
  end

end