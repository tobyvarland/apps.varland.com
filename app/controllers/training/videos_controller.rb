class Training::VideosController < ApplicationController

  skip_before_action :authenticate_user!

  before_action :set_training_video,
                only: %i[ show edit update destroy ]

  before_action :parse_filter_params, only: %i[ index ]

  has_scope :with_search_term

  def index
    authorize(Training::Video)
    filters_to_cookies
    begin
      @pagy, @training_videos = pagy(apply_scopes(Training::Video.order(:title)), items: 100)
    rescue
      @pagy, @training_videos = pagy(apply_scopes(Training::Video.order(:title)), items: 100, page: 1)
    end
  end

  def show
    authorize(@training_video)
  end

  def new
    authorize(Training::Video)
    @training_video = Training::Video.new
  end

  def edit
    authorize(@training_video)
  end

  def create
    @training_video = Training::Video.new(training_video_params)
    authorize(@training_video)
    if @training_video.save
      redirect_to @training_video, notice: "Video was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@training_video)
    if @training_video.update(training_video_params)
      redirect_to @training_video, notice: "Video was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@training_video)
    @training_video.destroy
    redirect_to training_videos_url, notice: "Video was successfully destroyed."
  end

  private

    def set_training_video
      @training_video = Training::Video.friendly.find(params[:id])
    end


    def training_video_params
      params.require(:training_video).permit(:title, :description, :url)
    end

end