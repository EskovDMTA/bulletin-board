# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :check_user_authenticate, only: %i[new create]

    def new
      user = User.find(session[:user_id])
      @bulletin = Bulletin.new(user_id: user.id)
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      @bulletin.user = current_user
      if @bulletin.save
        redirect_to root_path, notice: 'Bulletin was successfully created!'
      else
        render :new
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end

    def check_user_authenticate
      return unless session[:user_id].nil?

      redirect_to root_path, notice: 'Need authorize'
    end
  end
end
