class Projects::ItemsController < ApplicationController

  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @items = Projects::Item.all
  end

  def show
  end

  def new
    begin
      @system = Projects::System.find(params[:system])
    rescue
      redirect_back fallback_location: root_url, alert: "Failed to load new item form due to error loading system."
    end
    case @system.categories.length
    when 0
      redirect_back fallback_location: root_url, alert: "Cannot create new item because system has no categories defined."
    when 1
      @item = @system.categories.first.items.build
    else
      @item = Projects::Item.new
    end
    @item.comments.build(user: current_user)
  end

  def edit
    @system = @item.category.system
  end

  def create
    @item = Projects::Item.new(item_params)
    @system = @item.category.system
    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to projects_items_url, notice: "Item was successfully destroyed."
  end

  private

    def set_item
      @item = Projects::Item.find(params[:id])
    end

    def item_params
      params.require(:projects_item).permit(:category_id,
                                            :number,
                                            :status,
                                            :percent_complete,
                                            :priority,
                                            :due_on,
                                            :projected_hours,
                                            :description,
                                            :source,
                                            :designation,
                                            attachments_attributes: [:id,
                                                                     :file,
                                                                     :_destroy],
                                            assignments_attributes: [:id,
                                                                     :user_id,
                                                                     :_destroy])
    end

end