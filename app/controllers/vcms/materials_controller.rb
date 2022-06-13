class VCMS::MaterialsController < ApplicationController

  skip_before_action  :authenticate_user!
  before_action       :prevent_cache

  def open_po_report
    @data = load_json "http://json400.varland.com/open_po_report"
  end

end