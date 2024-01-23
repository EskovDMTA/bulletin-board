# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < ApplicationController
      def index
        @categories = Category.order(created_at: :desc).page(params[:page]).per(25)
      end

      def new
        @category = Category.new
      end

      def edit
        @category = Category.find(params[:id])
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_categories_path, notice: t('category_notice.create')
        else
          render :new, status: :unprocessable_entity, alert: 'Error'
        end
      end

      def update
        @category = Category.find(params[:id])

        if @category.update(category_params)
          redirect_to admin_categories_path, notice: t('category_notice.update')
        else
          render :edit, status: :unprocessable_entity, alert: 'Error'
        end
      end

      def destroy
        @category = Category.find(params[:id])

        if @category.bulletins.any?
          redirect_back fallback_location: admin_root_url, alert: t('category_notice.destroy.error')
        else
          @category.destroy
          redirect_back fallback_location: admin_root_url, notice: t('category_notice.destroy.success')
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
