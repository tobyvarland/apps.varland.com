class VCMS::ProductionController < ApplicationController

  skip_before_action  :authenticate_user!
  before_action       :prevent_cache

  def jobs_on_receipt
    @auto_refresh = 599
    @jobs = load_json "http://vcmsapi.varland.com/jobs_on_receipt"
  end

  def part_search
    query_fields = {}
    if params[:filters].present?
      [:customer, :process, :part, :sub, :base_metal, :industry, :sub_industry, :on_or_after, :on_or_before, :search].each do |sym|
        if params[:filters][sym].present?
          query_fields[sym] = CGI.escape(params[:filters][sym])
        end
      end
      if params[:filters][:active].present?
        query_fields[:active] = (params[:filters][:active] == "Active Only" ? "true" : "false")
      end
      if params[:filters][:developmental].present?
        query_fields[:developmental] = (params[:filters][:developmental] == "Developmental Only" ? "true" : "false")
      end
      [:valid_price, :valid_procedure].each do |sym|
        if params[:filters][sym].present?
          query_fields[sym] = (params[:filters][sym] == "Valid Only" ? "true" : "false")
        end
      end
    end
    url = nil
    if query_fields.size == 0
      url = "http://vcmsapi.varland.com/default_part_search_filters"
    else
      url = "http://vcmsapi.varland.com/part_search?"
      query_fields.each {|key, value|
        url << (url[-1] == "?" ? "" : "&") << "#{key}=#{value}"
      }
    end
    # puts "🔴 #{url}"
    @data = load_json url
    if query_fields.size > 0
      @pagy, @parts = pagy_array(@data[:parts], items: 50)
    end
  end

end