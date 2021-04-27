class ApplicationController < ActionController::Base

  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

    def user_not_authorized
      flash[:alert] = "You're not authorized for that function. Please try again or contact IT."
      redirect_back fallback_location: root_path
    end

end