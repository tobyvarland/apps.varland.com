require "test_helper"

class Projects::SystemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projects_system = projects_systems(:one)
  end

  test "should get index" do
    get projects_systems_url
    assert_response :success
  end

  test "should get new" do
    get new_projects_system_url
    assert_response :success
  end

  test "should create projects_system" do
    assert_difference('Projects::System.count') do
      post projects_systems_url, params: { projects_system: { abbreviation: @projects_system.abbreviation, name: @projects_system.name } }
    end

    assert_redirected_to projects_system_url(Projects::System.last)
  end

  test "should show projects_system" do
    get projects_system_url(@projects_system)
    assert_response :success
  end

  test "should get edit" do
    get edit_projects_system_url(@projects_system)
    assert_response :success
  end

  test "should update projects_system" do
    patch projects_system_url(@projects_system), params: { projects_system: { abbreviation: @projects_system.abbreviation, name: @projects_system.name } }
    assert_redirected_to projects_system_url(@projects_system)
  end

  test "should destroy projects_system" do
    assert_difference('Projects::System.count', -1) do
      delete projects_system_url(@projects_system)
    end

    assert_redirected_to projects_systems_url
  end
end
