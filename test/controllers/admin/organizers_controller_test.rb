# frozen_string_literal: true

require 'test_helper'

module Admin
  class OrganizersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    def setup
      sign_in administrators(:user)
      @organizer = organizers(:one)
    end

    test 'should show organizers list page' do
      get admin_organizers_path
      assert_select 'h3', text: 'Список организаторов'
    end

    test 'should show organizer' do
      get admin_organizer_url(@organizer)
      assert_response :success, 'does not show the organizer'
    end

    test 'should destroy organizer' do
      assert_difference('Organizer.count', -1) do
        delete admin_organizer_url(@organizer)
      end

      assert_redirected_to admin_organizers_path, 'does not redirect after remove organizer'
    end

    test 'should update organizer' do
      patch admin_organizer_url(@organizer), params: { organizer: { name: 'updated' } }

      assert_redirected_to admin_organizer_path(@organizer), 'does not redirect after update organizer'
      @organizer.reload
      assert_equal 'updated', @organizer.name, 'does not update organizer name'
    end

    test 'can create an organizer' do
      get '/admin/organizers/new'
      assert_response :success

      post '/admin/organizers',
           params: { organizer: { name: 'can create' } }
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select '.card-body span:first-of-type', 'can create'
    end
  end
end
