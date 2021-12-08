class Projects::ItemsController < ApplicationController

  before_action :set_item, only: %i[ show edit update destroy ]

  def index
    @items = Projects::Item.all
  end

  def show
  end

  def new
    @item = Projects::Item.new
  end

  def edit
  end

  def create
    @item = Projects::Item.new(item_params)
    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
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
      params.require(:projects_item).permit(:category_id, :number, :current_status, :current_status_at, :percent_complete, :current_priority, :current_priority_at, :due_on, :projected_hours)
    end

end