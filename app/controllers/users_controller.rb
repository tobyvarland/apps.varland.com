class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index], if: :json_request?

	def index
		@users = User.where(is_active: true).where("employee_number > 0").order(:employee_number).all
	end

end