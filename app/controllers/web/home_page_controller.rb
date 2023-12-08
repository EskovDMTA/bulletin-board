# frozen_string_literal: true

module Web
  class HomePageController < Web::ApplicationController
    def home
      @bulletins = Bulletin.order(created_at: :desc)
    end
  end
end
