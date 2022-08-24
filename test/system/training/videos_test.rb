require "application_system_test_case"

class Training::VideosTest < ApplicationSystemTestCase
  setup do
    @training_video = training_videos(:one)
  end

  test "visiting the index" do
    visit training_videos_url
    assert_selector "h1", text: "Training/Videos"
  end

  test "creating a Video" do
    visit training_videos_url
    click_on "New Training/Video"

    fill_in "Description", with: @training_video.description
    fill_in "Slug", with: @training_video.slug
    fill_in "Title", with: @training_video.title
    fill_in "Url", with: @training_video.url
    click_on "Create Video"

    assert_text "Video was successfully created"
    click_on "Back"
  end

  test "updating a Video" do
    visit training_videos_url
    click_on "Edit", match: :first

    fill_in "Description", with: @training_video.description
    fill_in "Slug", with: @training_video.slug
    fill_in "Title", with: @training_video.title
    fill_in "Url", with: @training_video.url
    click_on "Update Video"

    assert_text "Video was successfully updated"
    click_on "Back"
  end

  test "destroying a Video" do
    visit training_videos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video was successfully destroyed"
  end
end
