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

end