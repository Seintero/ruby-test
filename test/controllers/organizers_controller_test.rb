# frozen_string_literal: true

require 'test_helper'

class OrganizersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @organizer = organizers(:one)
  end

  test 'should show organizers list page' do
    get organizers_path
    assert_select 'h1', text: 'Список организаторов'
  end

  test 'should show organizer' do
    get organizer_url(@organizer)
    assert_response :success, 'does not show the organizer'
  end

  test 'not show organizer in admin' do
    get admin_organizer_url(@organizer)
    assert_redirected_to new_administrator_session_url, 'Open admin area for unauthorized user'
  end
end
