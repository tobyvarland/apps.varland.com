class Groov::LogMailer < ApplicationMailer

	# Load helpers.
	helper :groov

	# Default notification email.
	def log_notification
		return if params[:log].blank?
		@log = params[:log]
    mail  to:       @log.get_recipients,
          subject:  "#{@log.notification_settings[:subject]} (#{DateTime.current.strftime("%m/%d/%y %l:%M%P")})"
	end

end