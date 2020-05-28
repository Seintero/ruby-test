require 'test_helper'

class OrganizersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in admins(:user)
    @organizer = organizers(:one)
  end

  test "should show organizers list page" do
    get organizers_path
    assert_select "h1", text: "Список организаторов"
  end

  test "should show organizer" do
    get organizer_url(@organizer)
    assert_response :success, "does not show the organizer"
  end

  test "should destroy organizer" do
    assert_difference('Organizer.count', -1) do
      delete organizer_url(@organizer)
    end

    assert_redirected_to organizers_path, "does not redirect after remove organizer"
  end

  test "should update organizer" do
    patch organizer_url(@organizer), params: { organizer: { name: "updated" } }

    assert_redirected_to organizer_path(@organizer), "does not redirect after update organizer"
    @organizer.reload
    assert_equal "updated", @organizer.name, "does not update organizer name"
  end

  test "can create an organizer" do
    get "/organizers/new"
    assert_response :success

    post "/organizers",
         params: { organizer: { name: "can create" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h2", "can create"
  end

end
