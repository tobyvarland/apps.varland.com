class VCMS::SalesController < ApplicationController

  before_action :prevent_cache

  def recent_customers
    authorize :vcms, :recent_customers?
    @customers = load_json "http://vcmsapi.varland.com/recent_customers"
  end

  def quote_search
    query_fields = {}
    if params[:filters].present?
      [:customer, :process, :part, :sub, :on_or_after, :on_or_before, :search, :quote].each do |sym|
        if params[:filters][sym].present?
          query_fields[sym] = CGI.escape(params[:filters][sym])
        end
      end
      if params[:filters][:current].present?
        query_fields[:current] = (params[:filters][:current] == "Current Only" ? "true" : "false")
      end
    end
    url = nil
    @count_filters = query_fields.size
    if query_fields.size == 0
      url = "http://vcmsapi.varland.com/default_quote_search_filters"
    else
      url = "http://vcmsapi.varland.com/quote_search?"
      query_fields.each {|key, value|
        url << (url[-1] == "?" ? "" : "&") << "#{key}=#{value}"
      }
    end
    # puts "🔴 #{url}"
    @data = load_json url
    if query_fields.size > 0
      @pagy, @quotes = pagy_array(@data[:quotes], items: 50)
    end
  end

end