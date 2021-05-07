class VCMS::ProductionController < ApplicationController

  skip_before_action  :authenticate_user!

  def jobs_on_receipt
    @auto_refresh = 599
    @jobs = load_json "http://vcmsapi.varland.com/jobs_on_receipt"
  end

end