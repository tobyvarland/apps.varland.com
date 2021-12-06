class Projects::ItemsController < ApplicationController
  before_action :set_projects_item, only: %i[ show edit update destroy ]

  # GET /projects/items or /projects/items.json
  def index
    @projects_items = Projects::Item.all
  end

  # GET /projects/items/1 or /projects/items/1.json
  def show
  end

  # GET /projects/items/new
  def new
    @projects_item = Projects::Item.new
  end

  # GET /projects/items/1/edit
  def edit
  end

  # POST /projects/items or /projects/items.json
  def create
    @projects_item = Projects::Item.new(projects_item_params)

    respond_to do |format|
      if @projects_item.save
        format.html { redirect_to @projects_item, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @projects_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @projects_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/items/1 or /projects/items/1.json
  def update
    respond_to do |format|
      if @projects_item.update(projects_item_params)
        format.html { redirect_to @projects_item, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @projects_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @projects_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/items/1 or /projects/items/1.json
  def destroy
    @projects_item.destroy
    respond_to do |format|
      format.html { redirect_to projects_items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_item
      @projects_item = Projects::Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def projects_item_params
      params.require(:projects_item).permit(:category_id, :number, :current_status, :current_status_at, :percent_complete, :current_priority, :current_priority_at, :due_on, :projected_hours)
    end
end
