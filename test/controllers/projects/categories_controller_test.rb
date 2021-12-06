require "test_helper"

class Projects::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_category = projects_categories(:one)
  end

  test "should get index" do
    get projects_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_category_url
    assert_response :success
  end

  test "should create projects_category" do
    assert_difference('Projects::Category.count') do
      post projects_categories_url, params: { projects_category: { abbreviation: @projects_category.abbreviation, allow_children: @projects_category.allow_children, allow_requests: @projects_category.allow_requests, comment_sections: @projects_category.comment_sections, last_number_used: @projects_category.last_number_used, name: @projects_category.name, priority_levels: @projects_category.priority_levels, send_feedback: @projects_category.send_feedback, system_id: @projects_category.system_id, use_due_date: @projects_category.use_due_date, use_percent_complete: @projects_category.use_percent_complete, use_reviews: @projects_category.use_reviews, use_tasks: @projects_category.use_tasks, use_time_tracking: @projects_category.use_time_tracking } }
    end

    assert_redirected_to projects_category_url(Projects::Category.last)
  end

  test "should show projects_category" do
    get projects_category_url(@projects_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_category_url(@projects_category)
    assert_response :success
  end

  test "should update projects_category" do
    patch projects_category_url(@projects_category), params: { projects_category: { abbreviation: @projects_category.abbreviation, allow_children: @projects_category.allow_children, allow_requests: @projects_category.allow_requests, comment_sections: @projects_category.comment_sections, last_number_used: @projects_category.last_number_used, name: @projects_category.name, priority_levels: @projects_category.priority_levels, send_feedback: @projects_category.send_feedback, system_id: @projects_category.system_id, use_due_date: @projects_category.use_due_date, use_percent_complete: @projects_category.use_percent_complete, use_reviews: @projects_category.use_reviews, use_tasks: @projects_category.use_tasks, use_time_tracking: @projects_category.use_time_tracking } }
    assert_redirected_to projects_category_url(@projects_category)
  end

  test "should destroy projects_category" do
    assert_difference('Projects::Category.count', -1) do
      delete projects_category_url(@projects_category)
    end

    assert_redirected_to projects_categories_url
  end
end
