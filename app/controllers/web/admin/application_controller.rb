# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < ApplicationController
      layout 'admin'

      before_action :authorize_admin

      private

      def authorize_admin
        return if BulletinPolicy.new(current_user, nil).admin?

        redirect_to root_path, alert: t('bulletin_policy.only_for_admin', scope: 'pundit')
      end
    end
  end
end
