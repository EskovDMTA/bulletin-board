# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authorize_bulletin, only: %i[new create]
    before_action :set_bulletin, only: %i[update show edit to_moderate archive]

    def index
      @q = Bulletin.where(state: :published).order(title: :desc).ransack(params[:q])
      @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
    end

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
        redirect_to profile_path, notice: t('bulletin_notice.create')
      else
        render :new, status: :unprocessable_entity, alert: 'Error'
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('bulletin_notice.update')
      else
        render :edit, status: :unprocessable_entity, notice: 'Ошибка'
      end
    end

    def to_moderate
      @bulletin.to_moderate!
      redirect_to profile_path, notice: t('bulletin_notice.moderate')
    end

    def archive
      @bulletin.archive!
      redirect_to profile_path, notice: t('bulletin_notice.archive')
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
