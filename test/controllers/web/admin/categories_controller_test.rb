# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      test 'should get index' do
        get web_admin_categories_index_url
        assert_response :success
      end

      test 'should get new' do
        get web_admin_categories_new_url
        assert_response :success
      end

      test 'should get create' do
        get web_admin_categories_create_url
        assert_response :success
      end

      test 'should get delete' do
        get web_admin_categories_delete_url
        assert_response :success
      end
    end
  end
end
