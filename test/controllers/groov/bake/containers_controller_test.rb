require "test_helper"

class Groov::Bake::ContainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groov_bake_container = groov_bake_containers(:one)
  end

  test "should get index" do
    get groov_bake_containers_url
    assert_response :success
  end

  test "should get new" do
    get new_groov_bake_container_url
    assert_response :success
  end

  test "should create groov_bake_container" do
    assert_difference('Groov::Bake::Container.count') do
      post groov_bake_containers_url, params: { groov_bake_container: { bakestand_column: @groov_bake_container.bakestand_column, bakestand_row: @groov_bake_container.bakestand_row, description: @groov_bake_container.description, load_id: @groov_bake_container.load_id, oven_shelf: @groov_bake_container.oven_shelf, oven_shelf_rod_position: @groov_bake_container.oven_shelf_rod_position, oven_shelf_tray_position: @groov_bake_container.oven_shelf_tray_position, rod_cart_position: @groov_bake_container.rod_cart_position, rod_cart_shelf: @groov_bake_container.rod_cart_shelf } }
    end

    assert_redirected_to groov_bake_container_url(Groov::Bake::Container.last)
  end

  test "should show groov_bake_container" do
    get groov_bake_container_url(@groov_bake_container)
    assert_response :success
  end

  test "should get edit" do
    get edit_groov_bake_container_url(@groov_bake_container)
    assert_response :success
  end

  test "should update groov_bake_container" do
    patch groov_bake_container_url(@groov_bake_container), params: { groov_bake_container: { bakestand_column: @groov_bake_container.bakestand_column, bakestand_row: @groov_bake_container.bakestand_row, description: @groov_bake_container.description, load_id: @groov_bake_container.load_id, oven_shelf: @groov_bake_container.oven_shelf, oven_shelf_rod_position: @groov_bake_container.oven_shelf_rod_position, oven_shelf_tray_position: @groov_bake_container.oven_shelf_tray_position, rod_cart_position: @groov_bake_container.rod_cart_position, rod_cart_shelf: @groov_bake_container.rod_cart_shelf } }
    assert_redirected_to groov_bake_container_url(@groov_bake_container)
  end

  test "should destroy groov_bake_container" do
    assert_difference('Groov::Bake::Container.count', -1) do
      delete groov_bake_container_url(@groov_bake_container)
    end

    assert_redirected_to groov_bake_containers_url
  end
end
