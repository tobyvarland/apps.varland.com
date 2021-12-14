class Projects::CategoriesController < ApplicationController

  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Projects::Category.all
  end

  def edit
  end

  def show
    render "projects/categories/show.json"
  end

  def create
    @category = Projects::Category.new(category_params)
    if @category.save
      redirect_to admin_projects_system_path(@category.system), notice: "Category '#{@category.name}' was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_projects_system_path(@category.system), notice: "Category '#{@category.name}' was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.discard
    redirect_to admin_projects_system_path(@category.system), notice: "Category '#{@category.name}' was successfully destroyed."
  end

  private

    def set_category
      @category = Projects::Category.find(params[:id])
    end

    def category_params
      params.require(:projects_category).permit(:system_id,
                                                :name,
                                                :abbreviation,
                                                :last_number_used,
                                                :comment_sections,
                                                :source_options,
                                                :designation_options,
                                                :use_priorities,
                                                :use_tasks,
                                                :use_time_tracking,
                                                :use_reviews,
                                                :use_percent_complete,
                                                :allow_children,
                                                :allow_requests,
                                                :send_feedback,
                                                :use_due_date)
    end

end