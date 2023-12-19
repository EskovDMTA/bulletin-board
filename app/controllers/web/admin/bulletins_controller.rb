# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]

      def index
        @q = Bulletin.order(title: :desc).ransack(params[:q])
        @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
      end

      def new
        @bulletin = Bulletin.new
      end

      def create
        @bulletin = Bulletin.new(bulletin_params)
        if @bulletin.save
          redirect_to admin_bulletins_path, notice: t('bulletins_notice.created')
        else
          render :new
        end
      end

      def publish
        @bulletin.approve!
        redirect_to admin_bulletins_path, notice: t('bulletin_notice.publish')
      end

      def reject
        @bulletin.reject!
        redirect_to admin_bulletins_path, notice: t('bulletin_notice.reject')
      end

      def archive
        @bulletin.archive!
        redirect_to admin_bulletins_path, notice: t('bulletin_notice.archive')
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end

      def bulletin_params
        params.require(:bulletin).permit(:user, :image, :title, :description)
      end
    end
  end
end
