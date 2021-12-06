class Projects::SystemsController < ApplicationController
  before_action :set_projects_system, only: %i[ show edit update destroy ]

  # GET /projects/systems or /projects/systems.json
  def index
    @projects_systems = Projects::System.all
  end

  # GET /projects/systems/1 or /projects/systems/1.json
  def show
  end

  # GET /projects/systems/new
  def new
    @projects_system = Projects::System.new
  end

  # GET /projects/systems/1/edit
  def edit
  end

  # POST /projects/systems or /projects/systems.json
  def create
    @projects_system = Projects::System.new(projects_system_params)

    respond_to do |format|
      if @projects_system.save
        format.html { redirect_to @projects_system, notice: "System was successfully created." }
        format.json { render :show, status: :created, location: @projects_system }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @projects_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/systems/1 or /projects/systems/1.json
  def update
    respond_to do |format|
      if @projects_system.update(projects_system_params)
        format.html { redirect_to @projects_system, notice: "System was successfully updated." }
        format.json { render :show, status: :ok, location: @projects_system }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @projects_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/systems/1 or /projects/systems/1.json
  def destroy
    @projects_system.destroy
    respond_to do |format|
      format.html { redirect_to projects_systems_url, notice: "System was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_system
      @projects_system = Projects::System.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def projects_system_params
      params.require(:projects_system).permit(:name, :abbreviation)
    end
end
