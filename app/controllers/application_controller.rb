class ApplicationController < ActionController::Base

  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

    def parse_filter_params
      if params[:filters]
        params[:filters].each_key {|key| params[key] = params[:filters][key] }
      end
    end

    def prevent_cache
      response.headers["Cache-Control"] = "no-cache, no-store"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
    end

    def user_not_authorized
      flash[:alert] = "You're not authorized for that function. Please try again or contact IT."
      redirect_to root_path
    end

    def load_json(url)
      # puts "  🔴 Loading JSON: #{url}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      return nil unless response.code.to_s == "200"
      return JSON.parse(response.body, symbolize_names: true)
    end

    def filters_to_cookies(filters, options = {})
      reset = options.fetch :reset, false
      minutes = options.fetch :minutes, 60
      new_filters = nil
      filters.each do |f|
        cookie_name = "#{params[:controller]}_#{params[:action]}_#{f}".gsub("/", "__")
        if params[:reset] || reset
          cookies[cookie_name] = ""
          puts "🔴 ===> Resetting cookie: #{cookie_name}"
        else
          if params[:filters]
            if params[:filters][f]
              cookies[cookie_name] = { value: params[:filters][f], expires: minutes.minutes.from_now }
              puts "🔴 ===> Setting cookie: #{cookie_name} = #{params[:filters][f]}"
            end
          else
            if cookies[cookie_name] && !cookies[cookie_name].blank?
              new_filters = {} if new_filters.blank?
              new_filters[f] = cookies[cookie_name]
              puts "🔴 ===> Loading value from cookie: #{cookie_name} = #{cookies[cookie_name]}"
            end
          end
        end
      end
      params[:filters] = new_filters unless new_filters.blank?
      parse_filter_params
    end

end