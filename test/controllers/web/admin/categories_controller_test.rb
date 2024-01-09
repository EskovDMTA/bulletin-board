# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @category = categories(:one)
        @user = users(:admin)
      end

      test 'should be redirected if the user is not an admin.ru.yml' do
        get admin_categories_path
        assert_redirected_to root_path

        get new_admin_category_path
        assert_redirected_to root_path

        get edit_admin_category_path(@category)
        assert_redirected_to root_path

        delete admin_category_path(@category)
        assert_redirected_to root_path
      end

      test 'admin.ru.yml should be get category routes' do
        sign_in(@user)
        get admin_categories_path
        assert_response :success

        get new_admin_category_path
        assert_response :success

        get edit_admin_category_path(@category)
        assert_response :success
      end

      test 'admin.ru.yml should be create category' do
        sign_in(@user)
        post admin_categories_url, params: { category: { name: 'Новая категория' } }
        assert(Category.find_by(name: 'Новая категория'))
      end

      test 'admin.ru.yml should be destroy category' do
        sign_in(@user)
        delete admin_category_url(@category)
        assert_nil(Category.find_by(name: @category.name))
      end
    end
  end
end
