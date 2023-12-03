# frozen_string_literal: true

module Web
  class HomePageController < Web::ApplicationController
    def home
      @welcome = 'WelcomePage'
    end
  end
end
