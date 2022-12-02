class PagesController < ApplicationController

  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def home
  end

  def vacation_calendars
  end

  def reset_sidekiq_stats
    Sidekiq::Stats.new.reset
    redirect_to sidekiq_web_url
  end

  def open_parking_lot_gate
    OpenParkingLotGateJob.perform_later
    redirect_back fallback_location: root_path, notice: "Triggered button for opening parking lot gate."
  end

  def open_front_door
    OpenFrontDoorJob.perform_later
    redirect_back fallback_location: root_path, notice: "Triggered button for opening front door."
  end

  def open_hallway_door
    OpenHallwayDoorJob.perform_later
    redirect_back fallback_location: root_path, notice: "Triggered button for opening hallway door."
  end

  def screenshots
  end

  def schedule

    # Check for existing bearer token.
    cookie_token = nil
    if cookies["pp_bearer"] && !cookies["pp_bearer"].blank?
      puts "🔴 ===> Loading value from cookie: pp_bearer = #{cookies["pp_bearer"]}"
      cookie_token = cookies["pp_bearer"]
    end

    client = PayrollPartnersApiClient.new
    unless cookie_token.nil?
      client.token = cookie_token
    end
    @schedule = client.get_schedule

    respond_to do |format|
      format.json {
      }
      format.pdf {
        pdf = SchedulePdf.new(@schedule)
        send_data(pdf.render,
                  filename: "WeeklySchedule.pdf",
                  type: "application/pdf",
                  disposition: "inline")
      }
    end

    # If data retrieved successfully and didn't already have cookie, set cookie.
    if !@schedule.nil? && cookie_token.nil?
      cookies["pp_bearer"] = { value: client.token, expires: 59.minutes.from_now }
      puts "🔴 ===> Setting value of cookie: pp_bearer = #{client.token}"
    end

  end

  def pp_account_ids
    api_client = PayrollPartnersApiClient.new
    @employee_ids = api_client.get_account_ids
  end

  def foremen_email
    @foremen = User.as_foreman
    if @foremen.blank?
      @foremen = User.where(aux_foreman: true)
    end
    @email_addresses = ["vmsforemen@gmail.com"]
    @foremen.each do |f|
      @email_addresses << f.foreman_email
    end
  end

  def now

    # Get and categorize clocked in users.
    @foremen = []
    User.as_foreman.each do |employee|
      @foremen << employee.name
    end
    @foremen << "Nobody" if @foremen.empty?
    employees = User.clocked_in
    @clocked_in = {
      platers: [],
      maintenance: [],
      lab: [],
      shipping: [],
      supervisors: [],
      office: []
    }
    employees.each do |employee|
      case employee.employee_number
      when 0...200
        @clocked_in[:platers] << employee
      when 200...300
        @clocked_in[:maintenance] << employee
      when 300...400
        @clocked_in[:lab] << employee
      when 400...500
        @clocked_in[:shipping] << employee
      when 600...700
        @clocked_in[:supervisors] << employee
      when 800...900
        @clocked_in[:office] << employee
      when 1500...1600
        @clocked_in[:shipping] << employee
      end
    end

    # Define auto refresh interval.
    @auto_refresh = 30

  end

  def fin_report
    redirect_to format_report_url if params[:report_file].blank?
    pdf = FinancialReportPdf.new(params[:report_file])
    send_data(pdf.render,
              filename: "FinancialReport.pdf",
              type: "application/pdf",
              disposition: "inline")
  end

  def format_report
  end

end