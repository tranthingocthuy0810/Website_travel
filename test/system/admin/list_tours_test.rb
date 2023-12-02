require "application_system_test_case"

class Admin::ListToursTest < ApplicationSystemTestCase
  setup do
    @list_tour = list_tours(:one)
  end

  test "visiting the index" do
    visit list_tours_url
    assert_selector "h1", text: "List Tours"
  end

  test "creating a List tour" do
    visit list_tours_url
    click_on "New List Tour"

    fill_in "Category", with: @list_tour.category_id
    fill_in "Name", with: @list_tour.name
    click_on "Create List tour"

    assert_text "List tour was successfully created"
    click_on "Back"
  end

  test "updating a List tour" do
    visit list_tours_url
    click_on "Edit", match: :first

    fill_in "Category", with: @list_tour.category_id
    fill_in "Name", with: @list_tour.name
    click_on "Update List tour"

    assert_text "List tour was successfully updated"
    click_on "Back"
  end

  test "destroying a List tour" do
    visit list_tours_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "List tour was successfully destroyed"
  end
end
