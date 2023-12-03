# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
      redirect_to root_path, notice: 'Signed in successfully.'
    end

    def request
      redirect_to "/auth/#{params[:provider]}"
    end
  end
end
