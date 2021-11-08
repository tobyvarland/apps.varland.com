class Quality::SaltSpray::OptoPostDipsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :create
  skip_before_action :authenticate_user!, only: :create

  before_action :set_opto_post_dip, only: %i[ show edit update destroy ]

  has_scope :sorted_by, default: "newest", allow_blank: true

  def index
    begin
      @pagy, @opto_post_dips = pagy(apply_scopes(Quality::SaltSpray::OptoPostDip.includes(:shop_order).all), items: 100)
    rescue
      @pagy, @opto_post_dips = pagy(apply_scopes(Quality::SaltSpray::OptoPostDip.includes(:shop_order).all), items: 100, page: 1)
    end
  end

  def create
    @opto_post_dip = Quality::SaltSpray::OptoPostDip.new(opto_post_dip_params)
    if @opto_post_dip.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @opto_post_dip.destroy
    redirect_to opto_post_dips_url, notice: "Opto post dip was successfully destroyed."
  end

  private

    def set_opto_post_dip
      @opto_post_dip = Quality::SaltSpray::OptoPostDip.find(params[:id])
    end

    def opto_post_dip_params
      params.require(:opto_post_dip).permit(:post_dip_at,
                                            :vat,
                                            :description,
                                            :shop_order_id,
                                            :shop_order_number,
                                            :load,
                                            :dip_seconds)
    end

end