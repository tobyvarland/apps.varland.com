class Quality::RejectTagsController < ApplicationController

  before_action :set_reject_tag,
                only: %i[ show edit update destroy shop_order_partial_tag ]

  def index
    authorize Quality::RejectTag
    @reject_tags = Quality::RejectTag.includes(:user, :shop_order).all
  end

  def show
    authorize @reject_tag
    respond_to do |format|
      format.html {
        if current_user
          @comment = current_user.comments.build
        end
      }
      format.pdf {
        pdf = Quality::RejectTagPdf.new(@reject_tag)
        send_data(pdf.render,
                  filename: "#{@reject_tag.description}.pdf",
                  type: "application/pdf",
                  disposition: "attachment")
      }
    end
  end

  def shop_order_partial_tag
    authorize @reject_tag
    respond_to do |format|
      format.pdf {
        pdf = Quality::RejectTagPartialTagPdf.new(@reject_tag.shop_order)
        send_data(pdf.render,
                  filename: "#{@reject_tag.description}.pdf",
                  type: "application/pdf",
                  disposition: "attachment")
      }
    end
  end

  def new
    authorize Quality::RejectTag
    @reject_tag = Quality::RejectTag.new(user_id: current_user.id, rejected_on: Date.current, source_id: -1)
  end

  def edit
    authorize @reject_tag
    @reject_tag.print_partial_tag = false
    @reject_tag.source_id = -1 if @reject_tag.source_id.blank?
  end

  def create
    @reject_tag = Quality::RejectTag.new(reject_tag_params)
    authorize @reject_tag
    if @reject_tag.save
      Quality::RejectTagMailer.with(reject_tag: @reject_tag).notification_email.deliver_later
      Quality::PrintRejectTagJob.perform_later @reject_tag, "RejectTag", "RL"
      Quality::UpdateRejectTagCountJob.perform_later @reject_tag.shop_order.number
      redirect_to @reject_tag
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @reject_tag
    if @reject_tag.update(reject_tag_params)
      redirect_to @reject_tag
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @reject_tag
    @reject_tag.discard
    Quality::UpdateRejectTagCountJob.perform_later @reject_tag.shop_order.number
    redirect_to quality_reject_tags_url
  end

  def source_options_for_shop_order
    render json: Quality::RejectTag.source_options_for_shop_order(params[:shop_order])
  end

  def tag_number_for_shop_order
    last = Quality::RejectTag.with_shop_order(params[:shop_order]).order(number: :desc).first
    last_number = last.present? ? last.number : 0
    render json: (last_number + 1)
  end

  private

    def set_reject_tag
      id = nil
      if params[:id].present?
        id = params[:id]
      elsif params[:reject_tag_id].present?
        id = params[:reject_tag_id]
      end
      @reject_tag = Quality::RejectTag.friendly.find(id)
    end

    def reject_tag_params
      params.require(:quality_reject_tag).permit(:shop_order_number,
                                                 :number,
                                                 :source_id,
                                                 :rejected_on,
                                                 :user_id,
                                                 :loads_rejected,
                                                 :pounds,
                                                 :defect,
                                                 :defect_description,
                                                 :cause,
                                                 :cause_description,
                                                 :department,
                                                 :print_partial_tag,
                                                 attachments_attributes: [:id, :name, :description, :file, :_destroy],
                                                 loads_attributes: [:id, :number, :barrel, :station, :_destroy])
    end

end