class VCMS::SalesController < ApplicationController

  def recent_customers
    authorize :vcms, :recent_customers?
    @customers = load_json "http://vcmsapi.varland.com/recent_customers"
  end

end