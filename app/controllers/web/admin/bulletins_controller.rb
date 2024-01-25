# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[publish reject archive]

      def index
        @q = Bulletin.order(title: :desc).ransack(params[:q])
        @bulletins = @q.result.page(params[:page]).per(25)
      end

      def publish
        if @bulletin.may_publish?
          @bulletin.publish!
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.publish.success')
        else
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.publish.error')
        end
      end

      def reject
        if @bulletin.may_reject?
          @bulletin.reject!
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.reject.success')
        else
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.reject.error')
        end
      end

      def archive
        if @bulletin.archive?
          @bulletin.archive!
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.archive.success')
        else
          redirect_back fallback_location: admin_root_url, notice: t('bulletin_notice.archive.error')
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.find(params[:id])
      end
    end
  end
end
