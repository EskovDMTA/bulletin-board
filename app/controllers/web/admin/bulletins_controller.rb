# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      before_action :set_bulletin, only: %i[approve reject archive]

      def index
        @bulletins = Bulletin.order(created_at: :desc).page(params[:page]).per(25)
        authorize @bulletins, :admin_index?
      end

      def new
        @bulletin = Bulletin.new
        authorize @bulletin, :admin_new?
      end

      def create
        @bulletin = Bulletin.new(bulletin_params)
        authorize @bulletin, :admin_new?
        if @bulletin.save
          redirect_to admin_bulletins_path, notice: t('bulletins_notice.created')
        else
          render :new
        end
      end

      def approve
        @bulletin.approve!
        redirect_to @bulletin, notice: 'Bulletin approved and published.'
      end

      def reject
        @bulletin.reject!
        redirect_to @bulletin, notice: 'Bulletin rejected. Requires further modifications.'
      end

      def archive
        @bulletin.archive!
        redirect_to @bulletin, notice: 'Bulletin archived.'
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
