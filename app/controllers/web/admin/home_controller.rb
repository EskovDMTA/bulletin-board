# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.where(state: 'under_moderation')
      end
    end
  end
end
