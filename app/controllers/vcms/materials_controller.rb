class VCMS::MaterialsController < ApplicationController

  skip_before_action  :authenticate_user!
  before_action       :prevent_cache

  def open_po_report
    @data = load_json "http://json400.varland.com/open_po_report"

  end  

  def po_search
    query_fields = {}
    if params[:filters].present?
      [:search, :vendor, :account, :material, :on_or_after, :on_or_before].each do |sym|
        if params[:filters][sym].present?
          query_fields[sym] = CGI.escape(params[:filters][sym])
        end
      end
    end
    url = nil
    @count_filters = query_fields.size
    @data = nil
    if query_fields.size > 0 
      url = "http://vcmsapi.varland.com/purchase_orders?"
      query_fields.each {|key, value|
        url << (url[-1] == "?" ? "" : "&") << "#{key}=#{value}"
      }
      #puts "🔴 #{url}"
    @data = load_json url
   
      @pagy, @pos = pagy_array(@data[:matches], items: 50)
      puts @pos
    end      

  end
end  