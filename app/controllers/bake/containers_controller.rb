class Bake::ContainersController < ApplicationController
  before_action :set_bake_container, only: %i[ show edit update destroy ]

  # GET /bake/containers or /bake/containers.json
  def index
    @bake_containers = Bake::Container.all
  end

  # GET /bake/containers/1 or /bake/containers/1.json
  def show
  end

  # GET /bake/containers/new
  def new
    @bake_container = Bake::Container.new
  end

  # GET /bake/containers/1/edit
  def edit
  end

  # POST /bake/containers or /bake/containers.json
  def create
    @bake_container = Bake::Container.new(bake_container_params)

    respond_to do |format|
      if @bake_container.save
        format.html { redirect_to @bake_container, notice: "Container was successfully created." }
        format.json { render :show, status: :created, location: @bake_container }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bake/containers/1 or /bake/containers/1.json
  def update
    respond_to do |format|
      if @bake_container.update(bake_container_params)
        format.html { redirect_to @bake_container, notice: "Container was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bake/containers/1 or /bake/containers/1.json
  def destroy
    @bake_container.destroy
    respond_to do |format|
      format.html { redirect_to bake_containers_url, notice: "Container was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bake_container
      @bake_container = Bake::Container.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bake_container_params
      params.require(:bake_container).permit(:stand_id, :number)
    end
end
