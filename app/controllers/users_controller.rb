class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index] #, if: :json_request?
  skip_before_action :authenticate_user!, only: :punch_clock
  skip_before_action :verify_authenticity_token, only: :punch_clock

	def index
		@users = User.where(is_active: true).where("employee_number > 0").order(:employee_number).all
	end

	def punch_clock
		user = User.where(employee_number: params[:number]).first
		if user
			tstamp = nil
			if params[:status] == "in"
				tstamp = Time.at(params[:clocked_in_at].to_i)
			end
			user.update(clocked_in_at: tstamp)
		end
		render json: user
	end

end