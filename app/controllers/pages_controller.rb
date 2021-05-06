class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
  end

  def reset_sidekiq_stats
    Sidekiq::Stats.new.reset
    redirect_back fallback_location: root_url
  end

end