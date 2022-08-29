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

  def screenshots_app
    send_data(Rails.root.join('lib', 'assets', 'programs', "VarlandSS.exe"),
              filename: "VarlandSS.exe",
              type: "application/octet-stream",
              disposition: "inline")
  end

end