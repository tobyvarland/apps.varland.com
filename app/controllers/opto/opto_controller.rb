class Opto::OptoController < ApplicationController

  # Skip authenticity token and user login.
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  # Logs Trico load from BNA controller.
  def log_trico_load

    # Create Trico load.
    Shipping::TricoBin.create shop_order_number: params[:shop_order], load_at: DateTime.current, load_number: params[:load], scale_weight: params[:weight]

    # Render response.
    head :ok

  end

end