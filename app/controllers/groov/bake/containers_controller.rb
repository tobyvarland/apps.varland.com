class Groov::Bake::ContainersController < ApplicationController
  before_action :set_groov_bake_container, only: %i[ show edit update destroy ]

  # GET /groov/bake/containers or /groov/bake/containers.json
  def index
    @groov_bake_containers = Groov::Bake::Container.all
  end

  # GET /groov/bake/containers/1 or /groov/bake/containers/1.json
  def show
  end

  # GET /groov/bake/containers/new
  def new
    @groov_bake_container = Groov::Bake::Container.new
  end

  # GET /groov/bake/containers/1/edit
  def edit
  end

  # POST /groov/bake/containers or /groov/bake/containers.json
  def create
    @groov_bake_container = Groov::Bake::Container.new(groov_bake_container_params)

    respond_to do |format|
      if @groov_bake_container.save
        format.html { redirect_to @groov_bake_container, notice: "Container was successfully created." }
        format.json { render :show, status: :created, location: @groov_bake_container }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @groov_bake_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groov/bake/containers/1 or /groov/bake/containers/1.json
  def update
    respond_to do |format|
      if @groov_bake_container.update(groov_bake_container_params)
        format.html { redirect_to @groov_bake_container, notice: "Container was successfully updated." }
        format.json { render :show, status: :ok, location: @groov_bake_container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @groov_bake_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groov/bake/containers/1 or /groov/bake/containers/1.json
  def destroy
    @groov_bake_container.destroy
    respond_to do |format|
      format.html { redirect_to groov_bake_containers_url, notice: "Container was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_groov_bake_container
      @groov_bake_container = Groov::Bake::Container.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def groov_bake_container_params
      params.require(:groov_bake_container).permit(:load_id, :description, :bakestand_column, :bakestand_row, :rod_cart_shelf, :rod_cart_position, :oven_shelf, :oven_shelf_tray_position, :oven_shelf_rod_position)
    end
end
