class ApplicationController < ActionController::Base

  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

    def user_not_authorized
      flash[:alert] = "You're not authorized for that function. Please try again or contact IT."
      redirect_to root_path
    end

    def load_json(url)
      puts "  🔴 Loading JSON: #{url}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      return nil unless response.code.to_s == "200"
      return JSON.parse(response.body, symbolize_names: true)
    end

end