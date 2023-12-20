# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    def show
      @q = Bulletin.where(user_id: session[:user_id]).order(created_at: :desc).ransack(params[:q])
      @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
    end
  end
end
