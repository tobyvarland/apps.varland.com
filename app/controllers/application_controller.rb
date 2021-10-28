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

end