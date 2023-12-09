# frozen_string_literal: true

module Web
  module Admin
    class HomeController < Web::Admin::ApplicationController
      def index
        @bulletins = Bulletin.order(created_at: :desc)
      end
    end
  end
end
