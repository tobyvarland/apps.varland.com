class AS400Controller < ApplicationController

  def print_smalog_labels
    @shop_order = params[:shop_order]
    Shipping::PrintSmalogLabelsJob.perform_later @shop_order
    redirect_to smalog_labels_url
  end

end