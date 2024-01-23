# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']

      user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create!(build_auth_params(auth))
      sign_in(user)
      redirect_to root_path, notice: t('authentication.login')
    end

    def destroy
      sign_out
      redirect_to root_path, notice: t('authentication.logout')
    end

    private

    def build_auth_params(auth)
      {
        provider: auth['provider'],
        uid: auth['uid'],
        name: auth['info']['name'],
        email: auth['info']['email'],
        admin: true
      }
    end
  end
end
