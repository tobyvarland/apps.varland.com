require "test_helper"

class Bake::ContainersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bake_container = bake_containers(:one)
  end

  test "should get index" do
    get bake_containers_url
    assert_response :success
  end

  test "should get new" do
    get new_bake_container_url
    assert_response :success
  end

  test "should create bake_container" do
    assert_difference('Bake::Container.count') do
      post bake_containers_url, params: { bake_container: { number: @bake_container.number, stand_id: @bake_container.stand_id } }
    end

    assert_redirected_to bake_container_url(Bake::Container.last)
  end

  test "should show bake_container" do
    get bake_container_url(@bake_container)
    assert_response :success
  end

  test "should get edit" do
    get edit_bake_container_url(@bake_container)
    assert_response :success
  end

  test "should update bake_container" do
    patch bake_container_url(@bake_container), params: { bake_container: { number: @bake_container.number, stand_id: @bake_container.stand_id } }
    assert_redirected_to bake_container_url(@bake_container)
  end

  test "should destroy bake_container" do
    assert_difference('Bake::Container.count', -1) do
      delete bake_container_url(@bake_container)
    end

    assert_redirected_to bake_containers_url
  end
end
