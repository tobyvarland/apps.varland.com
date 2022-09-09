class PagesController < ApplicationController

  skip_before_action :authenticate_user!

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

  def now

    # Check for existing bearer token.
    cookie_token = nil
    if cookies["pp_bearer"] && !cookies["pp_bearer"].blank?
      puts "🔴 ===> Loading value from cookie: pp_bearer = #{cookies["pp_bearer"]}"
      cookie_token = cookies["pp_bearer"]
    end

    # Set up client and retrieve data.
    client = PayrollPartnersApiClient.new
    unless cookie_token.nil?
      client.token = cookie_token
    end
    @clocked_in = client.get_employees_in_now

    # If data retrieved successfully and didn't already have cookie, set cookie.
    if !@clocked_in.nil? && cookie_token.nil?
      cookies["pp_bearer"] = { value: client.token, expires: 59.minutes.from_now }
      puts "🔴 ===> Setting value of cookie: pp_bearer = #{client.token}"
    end

    # Define auto refresh interval.
    @auto_refresh = 300

  end

end