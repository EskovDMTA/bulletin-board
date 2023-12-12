# frozen_string_literal: true

module Web
  class ProfileController < Web::ApplicationController
    def index
      @q = Bulletin.where(user_id: session[:user_id]).order(created_at: :desc).ransack(params[:q])
      @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
    end
  end
end
