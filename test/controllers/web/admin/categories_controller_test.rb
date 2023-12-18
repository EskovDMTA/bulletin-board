# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @category = categories(:one)
        @user = users(:one)
      end

      test 'should be redirected if the user is not an admin' do
        get admin_categories_path
        assert_redirected_to root_path

        get new_admin_category_path
        assert_redirected_to root_path

        get edit_admin_category_path(@category)
        assert_redirected_to root_path

        delete admin_category_path(@category)
        assert_redirected_to root_path
      end

      test 'admin should be get category routes' do
        sign_in(@user)

        get admin_categories_path
        assert_response :success

        get new_admin_category_path
        assert_response :success

        get edit_admin_category_path(@category)
        assert_response :success
      end

      test 'admin should be create category' do
        sign_in(@user)

        assert_difference('Category.count') do
          post admin_categories_path, params: { category: { name: 'Новая категория' } }
        end
      end

      test 'admin should be destroy category' do
        sign_in(@user)
        assert_difference('Category.count', -1) do
          delete admin_category_path(@category)
        end
      end
    end
  end
end
