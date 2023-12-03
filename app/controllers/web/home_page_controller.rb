# frozen_string_literal: true

module Web
  class HomePageController < Web::ApplicationController
    def home
      @welcome = 'Welcome Page'
    end
  end
end
