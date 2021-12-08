class Projects::SystemsController < ApplicationController

  before_action :set_system, only: %i[ edit update destroy admin dashboard ]

  def index
    @systems = Projects::System.all
    @system = Projects::System.new
  end

  def admin
    @category = @system.categories.build(comment_sections: "Comments")
  end

  def dashboard
  end

  def new
    @system = Projects::System.new
  end

  def edit
  end

  def create
    @system = Projects::System.new(system_params)
    if @system.save
      redirect_to @system, notice: "System was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @system.update(system_params)
      redirect_to @system, notice: "System was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @system.discard
    redirect_to projects_systems_url, notice: "System was successfully destroyed."
  end

  private

    def set_system
      @system = Projects::System.find(params[:id])
    end

    def system_params
      params.require(:projects_system).permit(:name, :abbreviation)
    end

end