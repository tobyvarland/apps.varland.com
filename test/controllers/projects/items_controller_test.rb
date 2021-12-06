require "test_helper"

class Projects::ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_item = projects_items(:one)
  end

  test "should get index" do
    get projects_items_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_item_url
    assert_response :success
  end

  test "should create projects_item" do
    assert_difference('Projects::Item.count') do
      post projects_items_url, params: { projects_item: { category_id: @projects_item.category_id, current_priority: @projects_item.current_priority, current_priority_at: @projects_item.current_priority_at, current_status: @projects_item.current_status, current_status_at: @projects_item.current_status_at, due_on: @projects_item.due_on, number: @projects_item.number, percent_complete: @projects_item.percent_complete, projected_hours: @projects_item.projected_hours } }
    end

    assert_redirected_to projects_item_url(Projects::Item.last)
  end

  test "should show projects_item" do
    get projects_item_url(@projects_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_item_url(@projects_item)
    assert_response :success
  end

  test "should update projects_item" do
    patch projects_item_url(@projects_item), params: { projects_item: { category_id: @projects_item.category_id, current_priority: @projects_item.current_priority, current_priority_at: @projects_item.current_priority_at, current_status: @projects_item.current_status, current_status_at: @projects_item.current_status_at, due_on: @projects_item.due_on, number: @projects_item.number, percent_complete: @projects_item.percent_complete, projected_hours: @projects_item.projected_hours } }
    assert_redirected_to projects_item_url(@projects_item)
  end

  test "should destroy projects_item" do
    assert_difference('Projects::Item.count', -1) do
      delete projects_item_url(@projects_item)
    end

    assert_redirected_to projects_items_url
  end
end
