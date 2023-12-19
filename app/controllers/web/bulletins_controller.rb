# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize_bulletin, only: %i[new create]
    before_action :set_bulletin, only: %i[update show edit submit_for_moderation archive]

    def show; end

    def new
      user = User.find(session[:user_id])
      @bulletin = Bulletin.new(user_id: user.id)
      authorize @bulletin
    end

    def edit; end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      @bulletin.user = current_user
      if @bulletin.save
        redirect_to root_path, notice: t('bulletin_notice.create')
      else
        render :new, status: :unprocessable_entity, alert: 'Error'
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('bulletin_notice.update')
      else
        render :edit, status: :unprocessable_entity, notice: 'Ошибка'
      end
    end

    def submit_for_moderation
      @bulletin.submit_for_moderation!
      redirect_to @bulletin, notice: t('bulletin_notice.moderate')
    end

    def archive
      @bulletin.archive!
      redirect_to @bulletin, notice: t('bulletin_notice.archive')
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end

    def authorize_bulletin
      authorize Bulletin
    end
  end
end
