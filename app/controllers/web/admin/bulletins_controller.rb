# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.order(created_at: :desc)
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

      private

      def bulletin_params
        params.require(:bulletin).permit(:user, :image, :title, :description)
      end
    end
  end
end
