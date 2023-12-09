# frozen_string_literal: true

module Web
  class ProfileController < Web::ApplicationController
    def index
      @bulletins = Bulletin.where(user_id: session[:user_id])
    end
  end
end
