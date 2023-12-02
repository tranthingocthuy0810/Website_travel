require 'test_helper'

class Admin::ListToursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list_tour = list_tours(:one)
  end

  test "should get index" do
    get list_tours_url
    assert_response :success
  end

  test "should get new" do
    get new_list_tour_url
    assert_response :success
  end

  test "should create list_tour" do
    assert_difference('ListTour.count') do
      post list_tours_url, params: { list_tour: { category_id: @list_tour.category_id, name: @list_tour.name } }
    end

    assert_redirected_to list_tour_url(ListTour.last)
  end

  test "should show list_tour" do
    get list_tour_url(@list_tour)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_tour_url(@list_tour)
    assert_response :success
  end

  test "should update list_tour" do
    patch list_tour_url(@list_tour), params: { list_tour: { category_id: @list_tour.category_id, name: @list_tour.name } }
    assert_redirected_to list_tour_url(@list_tour)
  end

  test "should destroy list_tour" do
    assert_difference('ListTour.count', -1) do
      delete list_tour_url(@list_tour)
    end

    assert_redirected_to list_tours_url
  end
end
