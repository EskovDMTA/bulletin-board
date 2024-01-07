# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @category = categories(:one)
        @user = users(:one)
        sign_in(@user)
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
        get admin_categories_path
        assert_response :success

        get new_admin_category_path
        assert_response :success

        get edit_admin_category_path(@category)
        assert_response :success
      end

      test 'admin should be create category' do
        puts current_user.signed_in?
        post admin_categories_url, params: { category: { name: 'Новая категория' } }
        assert(Category.find_by(name: 'Новая категория'))
      end

      test 'admin should be destroy category' do
        delete admin_category_url(@category)
        assert_nil(Category.find_by(name: @category.name))
      end
    end
  end
end
