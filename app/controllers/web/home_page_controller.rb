# frozen_string_literal: true

module Web
  class HomePageController < Web::ApplicationController
    def home
      @q = Bulletin.order(title: :desc).ransack(params[:q])
      @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
    end
  end
end
