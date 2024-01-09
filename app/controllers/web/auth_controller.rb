# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_path, notice: t('authentication.login')
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.email = auth['info']['email']
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: t('authentication.logout')
    end
  end
end
