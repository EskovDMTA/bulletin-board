# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize_bulletin, only: %i[new create]
    before_action :set_bulletin, only: %i[update destroy submit_for_moderation archive]

    def new
      user = User.find(session[:user_id])
      @bulletin = Bulletin.new(user_id: user.id)
      authorize @bulletin
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

    def update
      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: 'Bulletin was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @bulletin.destroy
      redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
    end

    def submit_for_moderation
      @bulletin.submit_for_moderation!
      redirect_to @bulletin, notice: 'Bulletin submitted for moderation.'
    end

    def archive
      @bulletin.archive!
      redirect_to @bulletin, notice: 'Bulletin archived.'
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end

    # def check_user_authenticate
    #   return unless session[:user_id].nil?
    #
    #   redirect_to root_path, notice: 'Need authorize'
    # end
    def authorize_bulletin
      authorize Bulletin
    end
  end
end
