class Bake::StandsController < ApplicationController
  before_action :set_bake_stand, only: %i[ show edit update destroy ]

  # GET /bake/stands or /bake/stands.json
  def index
    @bake_stands = Bake::Stand.all
  end

  # GET /bake/stands/1 or /bake/stands/1.json
  def show
  end

  # GET /bake/stands/new
  def new
    @bake_stand = Bake::Stand.new
  end

  # GET /bake/stands/1/edit
  def edit
  end

  # POST /bake/stands or /bake/stands.json
  def create
    @bake_stand = Bake::Stand.new(bake_stand_params)

    respond_to do |format|
      if @bake_stand.save
        format.html { redirect_to @bake_stand, notice: "Stand was successfully created." }
        format.json { render :show, status: :created, location: @bake_stand }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bake_stand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bake/stands/1 or /bake/stands/1.json
  def update
    respond_to do |format|
      if @bake_stand.update(bake_stand_params)
        format.html { redirect_to @bake_stand, notice: "Stand was successfully updated." }
        format.json { render :show, status: :ok, location: @bake_stand }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bake_stand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bake/stands/1 or /bake/stands/1.json
  def destroy
    @bake_stand.destroy
    respond_to do |format|
      format.html { redirect_to bake_stands_url, notice: "Stand was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bake_stand
      @bake_stand = Bake::Stand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bake_stand_params
      params.require(:bake_stand).permit(:cycle_id, :type, :name)
    end
end
