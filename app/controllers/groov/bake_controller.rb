class Groov::BakeController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @pre_bake_cycles = Groov::Bake::Cycle.pre_bake
    @cycles_baking_now = Groov::Bake::Cycle.baking_now.by_cycle_started
    @recently_finished_cycles = Groov::Bake::Cycle.post_bake.by_cycle_ended.limit(10)
  end

  def history
  end

end